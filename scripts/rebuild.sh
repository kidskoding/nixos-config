#!/usr/bin/env bash
#
# rebuild nixos, then commit and push with the generation as the message.
# the neovim config also goes to its own repo, kidskoding.nvim, with the same message.
#
# run it from anywhere: ~/nixos/scripts/rebuild.sh

set -euo pipefail

FLAKE_DIR="${FLAKE_DIR:-$HOME/nixos}"
HOST="${HOST:-thinkpad}"
NVIM_DIR=modules/nvim/config

cd "$FLAKE_DIR"

# copy the neovim folder's history out of this repo and push it to kidskoding.nvim
push_nvim() {
    git fetch -q nvim master || return 1
    local remote split
    remote=$(git rev-parse FETCH_HEAD)
    split=$(git subtree split -S --prefix="$NVIM_DIR" HEAD) || return 1

    # the remote can hold commits that were later rewritten here; rejoin at the matching tree
    if ! git merge-base --is-ancestor "$remote" "$split"; then
        local remote_tree mainline=""
        remote_tree=$(git rev-parse "$remote^{tree}")
        for commit in $(git log --format=%H -- "$NVIM_DIR"); do
            if [ "$(git rev-parse "$commit:$NVIM_DIR")" = "$remote_tree" ]; then
                mainline=$commit
                break
            fi
        done
        if [ -z "$mainline" ]; then
            echo "kidskoding.nvim has changes that are not here; merge them first." >&2
            return 1
        fi
        git commit --allow-empty --only -m "Rejoin Neovim subtree with remote" \
            -m "git-subtree-dir: $NVIM_DIR
git-subtree-mainline: $mainline
git-subtree-split: $remote" || return 1
        split=$(git subtree split -S --prefix="$NVIM_DIR" HEAD) || return 1
    fi

    git push -q nvim "$split:refs/heads/master"
}

push_all() {
    if ! git push -q origin HEAD && ! { git pull -q --rebase --autostash && git push -q origin HEAD; }; then
        echo "push failed; commit is local only. fix any rebase conflict, then rerun this script."
    fi
    push_nvim || echo "kidskoding.nvim push failed; rerun this script to retry."
}

# 1. update
git pull -q --rebase --autostash

# pull the latest agent skills (anikonistack) and the noctalia family from
# github before building, so every host locks the same versions in flake.lock
nix flake update anikonistack

# 2. stage and format
# flakes only see files that git knows about, so stage everything first!
git add -A

if git diff --cached --quiet; then
    echo "no changes detected; pushing anything left over."
    push_all
    exit 0
fi

mapfile -t nix_files < <(git diff --cached --name-only --diff-filter=ACMR -- '*.nix')
if [ ${#nix_files[@]} -gt 0 ]; then
    alejandra -q "${nix_files[@]}"
fi

# stylua needs to run inside the neovim folder to pick up its .stylua.toml
mapfile -t lua_files < <(git diff --cached --name-only --diff-filter=ACMR --relative="$NVIM_DIR" -- "$NVIM_DIR/*.lua")
if [ ${#lua_files[@]} -gt 0 ]; then
    (cd "$NVIM_DIR" && stylua "${lua_files[@]}")
fi

git add -A
git --no-pager diff --cached --stat
DFT_DISPLAY=inline git --no-pager diff --cached

# 3. rebuild
echo "rebuilding nixos..."
before=$(readlink -f /run/current-system)

if ! script -qefc "sudo nixos-rebuild switch --flake \"$FLAKE_DIR#$HOST\" --upgrade" nixos-switch.log; then
    grep --color error nixos-switch.log || tail -n 40 nixos-switch.log
    exit 1
fi

if command -v nvd &> /dev/null; then
    nvd diff "$before" /run/current-system || true
fi

# 4. commit and push
# nixos-rebuild-ng prints a table whose last column is True for the live
# generation, so match that rather than grepping for the word "current".
gen=$(nixos-rebuild list-generations 2>/dev/null | awk 'NR > 1 && $NF == "True"')

if [ -n "$gen" ]; then
    msg="$HOST generation $(echo "$gen" | awk '{print $1}') ($(echo "$gen" | awk '{print $4}'))"
else
    msg="nixos rebuild $(date -Iseconds)"
fi

git commit -m "$msg"
push_all

#!/usr/bin/env bash
#
# commit and push the neovim config on its own.
# the config is a subtree of codeberg.org/kidskoding/kidskoding.nvim!
#
# run it from anywhere: ~/nixos/scripts/nvim-sync.sh

set -euo pipefail

NIXOS_DIR="${NIXOS_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
NVIM_DIR=modules/nvim/config

cd "$NIXOS_DIR"

# Reconnect subtree history once after the folder relocation is committed.
if [ -z "$(git log -1 --format=%H --grep="^git-subtree-dir: $NVIM_DIR/*$")" ]; then
    legacy_dir="programs/nvim"
    relocation=$(git log -1 --diff-filter=D --format=%H -- "$legacy_dir/init.lua")
    if [ -z "$relocation" ]; then
        echo "commit the Neovim folder relocation with the rest of the config first." >&2
        exit 1
    fi
    mainline=$(git rev-parse "$relocation^")
    split=$(git subtree split -S --prefix="$legacy_dir" "$mainline")
    git commit --allow-empty --only -m "Reconnect Neovim subtree after relocation" \
        -m "git-subtree-dir: $NVIM_DIR
git-subtree-mainline: $mainline
git-subtree-split: $split"
fi

if [ -z "$(git status --porcelain -- "$NVIM_DIR")" ]; then
    echo "no new neovim changes; pushing existing commits."
else
    git add -A -- "$NVIM_DIR"

    # autoformat only the fennel files that actually changed, the repo's ci checks this
    mapfile -t changed < <(git diff --cached --name-only --diff-filter=ACMR -- "$NVIM_DIR/*.fnl")
    if [ ${#changed[@]} -gt 0 ]; then
        fnlfmt --fix "${changed[@]}"
        git add -A -- "$NVIM_DIR"
    fi

    git --no-pager diff --cached --stat -- "$NVIM_DIR"

    read -rp "neovim commit message: kidskoding.nvim: " msg
    git commit -m "kidskoding.nvim: ${msg:-update}" -- "$NVIM_DIR"
fi

git fetch -q nvim master
remote=$(git rev-parse FETCH_HEAD)
split=$(git subtree split -S --prefix="$NVIM_DIR" HEAD)

# the remote can hold commits that were later rewritten here; rejoin at the matching tree
if ! git merge-base --is-ancestor "$remote" "$split"; then
    remote_tree=$(git rev-parse "$remote^{tree}")
    mainline=""
    for commit in $(git log --format=%H -- "$NVIM_DIR"); do
        if [ "$(git rev-parse "$commit:$NVIM_DIR")" = "$remote_tree" ]; then
            mainline=$commit
            break
        fi
    done
    if [ -z "$mainline" ]; then
        echo "the remote has neovim changes that are not here; merge them first." >&2
        exit 1
    fi
    git commit --allow-empty --only -m "Rejoin Neovim subtree with remote" \
        -m "git-subtree-dir: $NVIM_DIR
git-subtree-mainline: $mainline
git-subtree-split: $remote"
    split=$(git subtree split -S --prefix="$NVIM_DIR" HEAD)
fi

git push nvim "$split:refs/heads/master"

if ! git push origin HEAD; then
    echo "push failed; commit is local only. run 'git push' later."
fi

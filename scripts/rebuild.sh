#!/usr/bin/env bash
#
# a rebuild script that commits on a successful build!
#
# run it from anywhere: ~/nixos/scripts/rebuild.sh

set -euo pipefail

FLAKE_DIR="${FLAKE_DIR:-$HOME/nixos}"
HOST="${HOST:-thinkpad}"

cd "$FLAKE_DIR"

git pull -q --rebase --autostash

# pull the latest agent skills (anikonistack) from 
# github before building, so every host locks the same versions in flake.lock
nix flake update anikonistack

# flakes only see files that git knows about, so stage everything first!
git add -A

# no changes still rebuilds (e.g. after switching branches), just skips the commit
changes=true
if git diff --cached --quiet; then
    changes=false
    echo "no changes detected, rebuilding without a commit."
else
    echo "formatting to enforce ci"
    alejandra -q .
    (cd modules/nvim/config && stylua .)
    git add -A

    git --no-pager diff --cached --stat
    DFT_DISPLAY=inline git --no-pager diff --cached
fi

echo "rebuilding nixos..."

before=$(readlink -f /run/current-system)

if ! script -qefc "sudo nixos-rebuild switch --flake \"$FLAKE_DIR#$HOST\" --upgrade" nixos-switch.log; then
    rg error nixos-switch.log || tail -n 40 nixos-switch.log
    exit 1
fi

if command -v nvd &> /dev/null; then
    nvd diff "$before" /run/current-system || true
fi

if [ "$changes" = false ]; then
    exit 0
fi

# commit with the generation metadata.
gen=$(nixos-rebuild list-generations 2>/dev/null | awk 'NR > 1 && $NF == "True"')

if [ -n "$gen" ]; then
    msg="$HOST generation $(echo "$gen" | awk '{print $1}') ($(echo "$gen" | awk '{print $4}'))"
else
    msg="nixos rebuild $(date -Iseconds)"
fi

git commit -m "$msg"

if ! git push -q origin HEAD && ! { git pull -q --rebase --autostash && git push -q origin HEAD; }; then
    echo "push failed; commit is local only. fix any rebase conflict, then run 'git push'."
fi

# send the neovim part of that commit to kidskoding.nvim. the copied commits are
# signed too; ed25519 ssh signatures are deterministic, so every split rebuilds
# the same hashes and the push stays a fast-forward.
git subtree push -q --prefix=modules/nvim/config nvim master ||
    echo "kidskoding.nvim push failed; rerun: git subtree push --prefix=modules/nvim/config nvim master"

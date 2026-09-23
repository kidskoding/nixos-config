#!/usr/bin/env bash
#
# commit and push the neovim config on its own.
# the config is a subtree of github.com/kidskoding/kidskoding.nvim!
#
# run it from anywhere: ~/nixos/scripts/nvim-sync.sh

set -euo pipefail

NIXOS_DIR="${NIXOS_DIR:-$HOME/nixos}"
NVIM_DIR="home-manager/programs/nvim"

cd "$NIXOS_DIR"

if [ -z "$(git status --porcelain -- "$NVIM_DIR")" ]; then
    echo "no neovim changes."
    exit 0
fi

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

git subtree push --prefix="$NVIM_DIR" nvim master

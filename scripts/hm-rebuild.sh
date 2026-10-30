#!/usr/bin/env bash
#
# home-manager rebuild for non-nixos machines that commits on a successful switch!
#
# run it from anywhere: ~/home-manager/scripts/hm-rebuild.sh

set -euo pipefail

FLAKE_DIR="${FLAKE_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"

cd "$FLAKE_DIR"

# pull the latest agent skills (anikonistack) before building
nix flake update anikonistack

# flakes only see files that git knows about, so stage everything first!
stage_config() {
    if [ -n "$(git ls-files -- modules/nvim/config)" ]; then
        # scripts/nvim-sync.sh commits and pushes Neovim changes separately.
        git add -A -- . ':!modules/nvim/config'
    else
        # Include the subtree on the first rebuild after moving it here.
        git add -A -- .
    fi
}
stage_config

if git diff --cached --quiet; then
    echo "no changes detected, exiting."
    exit 0
fi

# autoformat only the nix files that actually changed
echo "formatting all nix files to enforce ci"
mapfile -t changed < <(git diff --cached --name-only --diff-filter=ACMR -- '*.nix')
if [ ${#changed[@]} -gt 0 ]; then
    alejandra -q "${changed[@]}"
    stage_config
fi

# show what changed: every staged file, then a structural diff via difftastic 
git --no-pager diff --cached --stat
DFT_DISPLAY=inline git --no-pager diff --cached

echo "rebuilding home-manager..."

if ! script -qefc "home-manager switch --impure --flake \"$FLAKE_DIR#kidskoding\"" home-manager-switch.log; then
    grep --color error home-manager-switch.log || tail -n 40 home-manager-switch.log
    exit 1
fi

# newest generation first: "2026-10-30 12:00 : id 5 -> /nix/store/..."
gen=$(home-manager generations 2>/dev/null | head -n 1)

if [ -n "$gen" ]; then
    msg="home-manager generation $(echo "$gen" | awk '{print $5}') ($(echo "$gen" | awk '{print $1}'))"
else
    msg="home-manager switch $(date -Iseconds)"
fi

git commit -m "$msg"

if ! git push origin HEAD; then
    echo "push failed; commit is local only. run 'git push' later."
fi

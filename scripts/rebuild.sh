#!/usr/bin/env bash
#
# a rebuild script that commits on a successful build!
#
# run it from anywhere: ~/nixos/scripts/rebuild.sh

set -euo pipefail

FLAKE_DIR="${FLAKE_DIR:-$HOME/nixos}"
HOST="${HOST:-nixos}"

cd "$FLAKE_DIR"

# flakes only see files that git knows about, so stage everything first!
git add -A

if git diff --cached --quiet -- '*.nix' flake.lock; then
    echo "no changes detected, exiting."
    exit 0
fi

# autoformat only the nix files that actually changed
echo "formatting all nix files to enforce ci"
mapfile -t changed < <(git diff --cached --name-only --diff-filter=ACMR -- '*.nix')
if [ ${#changed[@]} -gt 0 ]; then
    alejandra -q "${changed[@]}"
    git add -A
fi

# show what changed
git --no-pager diff --cached -U0 -- '*.nix'

echo "rebuilding nixos..."

before=$(readlink -f /run/current-system)

if ! script -qefc "sudo nixos-rebuild switch --flake \"$FLAKE_DIR#$HOST\"" nixos-switch.log; then
    grep --color error nixos-switch.log || tail -n 40 nixos-switch.log
    exit 1
fi

# show what the new generation actually changed
if command -v nvd &> /dev/null; then
    nvd diff "$before" /run/current-system || true
fi

# commit with the generation metadata.
# nixos-rebuild-ng prints a table whose last column is True for the live
# generation, so match that rather than grepping for the word "current".
gen=$(nixos-rebuild list-generations 2>/dev/null | awk 'NR > 1 && $NF == "True"')

if [ -n "$gen" ]; then
    msg="generation $(echo "$gen" | awk '{print $1}') ($(echo "$gen" | awk '{print $4}'))"
else
    msg="nixos rebuild $(date -Iseconds)"
fi

git commit -m "$msg"

# if command -v notify-send &> /dev/null; then
#     notify-send -e "nixos rebuilt ok!" --icon=software-update-available
# fi

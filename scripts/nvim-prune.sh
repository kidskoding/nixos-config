#!/usr/bin/env bash
#
# remove neovim plugins that are installed but no longer in the config.
#
# run it from anywhere: ~/nixos/scripts/nvim-prune.sh

set -euo pipefail

NIXOS_DIR="${NIXOS_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
NVIM_DIR="$NIXOS_DIR/modules/nvim/config"
PACK_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/pack/core/opt"

mapfile -t orphans < <(comm -23 \
    <(find "$PACK_DIR" -mindepth 1 -maxdepth 1 -printf '%f\n' | sort) \
    <(grep -rhoE 'https://github.com/[^"]+' "$NVIM_DIR/fnl" "$NVIM_DIR/init.lua" \
        | sed -e 's#.*/##' -e 's#\.git$##' | sort -u))

if [ ${#orphans[@]} -eq 0 ]; then
    echo "no orphaned plugins."
    exit 0
fi

printf '  %s\n' "${orphans[@]}"
read -rp "remove these plugins? [y/N] " answer
[[ "$answer" =~ ^[Yy]$ ]] || exit 0

list=$(printf '"%s",' "${orphans[@]}")
nvim --headless -c "lua vim.pack.del({${list%,}})" -c 'qa'
echo "removed ${#orphans[@]} plugin(s)."

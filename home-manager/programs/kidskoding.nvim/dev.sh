#!/usr/bin/env bash
#
# bash script to aid in development for this config!

set -euo pipefail

APP="kidskoding.nvim"
REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LINK="${XDG_CONFIG_HOME:-$HOME/.config}/$APP"

# symlink this repo as the config dir: don't overwrite!
if [ ! -e "$LINK" ]; then
    ln -s "$REPO" "$LINK"
    echo "linked $LINK -> $REPO"
elif [ "$(readlink -f "$LINK")" != "$REPO" ]; then
    echo "error: $LINK exists and is not this repo" >&2
    exit 1
fi

export NVIM_APPNAME="$APP"

if command -v nix >/dev/null; then
    exec nix run nixpkgs#neovim-unwrapped -- "$@"
else
    exec nvim "$@"
fi

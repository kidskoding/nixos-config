#!/usr/bin/env bash
#
# switch the whole desktop theme without a rebuild: theme gruvbox|catppuccin|tokyonight
#
# each theme is a prebuilt specialisation (see modules/stylix/default.nix), so this
# only activates it. a rebuild or a reboot puts you back on gruvbox.

set -euo pipefail

# noctalia has its own builtin palettes, not stylix's
declare -A noctalia=([gruvbox]=Gruvbox [catppuccin]=Catppuccin [tokyonight]=Tokyo-Night)

name="${1:-}"
if [[ -z "${noctalia[$name]:-}" ]]; then
    echo "usage: theme ${!noctalia[*]}"
    exit 1
fi

profile=/nix/var/nix/profiles/system
[[ $name == gruvbox ]] || profile+="/specialisation/$name"

if [[ ! -x "$profile/bin/switch-to-configuration" ]]; then
    echo "no $name variant in the current generation; run rebuild first."
    exit 1
fi

sudo "$profile/bin/switch-to-configuration" switch

noctalia msg color-scheme-set builtin "${noctalia[$name]}" ||
    echo "noctalia not running; its colors were not changed."

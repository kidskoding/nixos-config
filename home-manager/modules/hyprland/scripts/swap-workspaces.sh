#!/usr/bin/env bash

# swap all windows between two workspaces
set -euo pipefail

from="$1"
to="$2"

clients=$(hyprctl clients -j)
from_wins=$(jq -r --argjson id "$from" '.[] | select(.workspace.id == $id) | .address' <<< "$clients")
to_wins=$(jq -r --argjson id "$to" '.[] | select(.workspace.id == $id) | .address' <<< "$clients")

for addr in $from_wins; do
    hyprctl dispatch movetoworkspacesilent "$to,address:$addr"
done

for addr in $to_wins; do
    hyprctl dispatch movetoworkspacesilent "$from,address:$addr"
done

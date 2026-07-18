#!/bin/bash

CACHE_DIR="/tmp/waybar_spotify"
mkdir -p "$CACHE_DIR"
COVER="$CACHE_DIR/cover.png"

if pgrep -f spotify > /dev/null; then
    URL=$(playerctl -p spotify metadata mpris:artUrl 2>/dev/null)
    if [ -n "$URL" ]; then
        curl -s "$URL" -o "$COVER"
    else
        rm -f "$COVER"
    fi
else
    rm -f "$COVER"
fi

pkill -RTMIN+1 waybar

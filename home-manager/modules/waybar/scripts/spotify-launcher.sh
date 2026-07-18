#!/bin/bash

# 1. Kill any old versions of your scripts so they don't double up
pkill -f spotify-text.sh
pkill -f get-album-cover.sh

# 2. Re-create the temp folder in case it was wiped on reboot
mkdir -p /tmp/waybar_spotify

# 3. Trigger the FIRST album cover download immediately 
# so the bar isn't empty when you first log in
~/.config/waybar/scripts/get-album-cover.sh &

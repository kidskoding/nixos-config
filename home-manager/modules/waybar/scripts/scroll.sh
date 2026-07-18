#!/usr/bin/env bash

WIDTH=35

get_status() { playerctl -p spotify status 2>/dev/null; }
get_text() { playerctl -p spotify metadata --format '{{title}} - {{artist}}' 2>/dev/null; }

while true; do
    if ! pgrep -f spotify-wrapped > /dev/null; then
        echo "Spotify is Offline!"
        sleep 2
        continue
    fi
    
    text=$(get_text)
    
    if [ -z "$text" ]; then
        echo "" 
        sleep 2
        continue
    fi

    len_text=${#text}
    pos=0
    direction=1

    while true; do
        status=$(get_status)
        current_text=$(get_text)

        if [ "$current_text" != "$text" ] || [ -z "$current_text" ]; then 
            break 
        fi

        if [ "$len_text" -le "$WIDTH" ]; then
            echo "$text"
            sleep 1
        else
            slice="${text:$pos:$WIDTH}"
            printf "%-${WIDTH}s\n" "$slice"

            if [ "$status" = "Playing" ]; then
                if [ $((pos + WIDTH)) -ge "$len_text" ] && [ "$direction" -eq 1 ]; then
                    sleep 3
                    direction=-1
                elif [ "$pos" -le 0 ] && [ "$direction" -eq -1 ]; then
                    sleep 3
                    direction=1
                fi
                pos=$((pos + direction))
                sleep 0.4
            else
                pos=0 
                direction=1
                sleep 1
            fi
        fi
    done
done

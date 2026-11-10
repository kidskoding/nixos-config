# usage: screenshot [region]

dir="$HOME/Pictures/Screenshots"
mkdir -p "$dir"
file="$dir/$(date +%Y-%m-%dT%H:%M:%S).png"

if [ "${1:-}" = region ]; then
  grim -g "$(slurp)" "$file"
else
  grim "$file"
fi

wl-copy < "$file"
notify-send -a Screenshot -i "$file" "Screenshot saved" "$file"

# usage: theme            list themes, * marks the active one
#        theme <name>     switch the whole system to <name>, no rebuild

system=/nix/var/nix/profiles/system
default=$(cat "$system/etc/theme")
current=$(cat /etc/theme)

if [ $# -eq 0 ]; then
    for name in "$default" "$system"/specialisation/*; do
        name=${name##*/}
        if [ "$name" = "$current" ]; then
            echo "* $name"
        else
            echo "  $name"
        fi
    done
    exit 0
fi

if [ "$1" = "$default" ]; then
    target=$system
else
    target=$system/specialisation/$1
fi

if [ ! -e "$target/bin/switch-to-configuration" ]; then
    echo "unknown theme: $1 (run 'theme' to list them)"
    exit 1
fi

sudo "$target/bin/switch-to-configuration" switch
echo "switched to $1; restart open terminals to pick it up."

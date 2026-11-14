system=/nix/var/nix/profiles/system
target=$system/specialisation/$1

if [ ! -d "$target" ]; then
    target=$system
fi

pkexec "$target/bin/switch-to-configuration" switch

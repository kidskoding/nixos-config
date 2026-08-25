{ config, lib, pkgs, ... }:

let
  fg = c: "38;2;${c}";
  a = config.theme.ansi;

  render = attrs: lib.concatStringsSep ":" (lib.mapAttrsToList (k: v: "${k}=${v}") attrs);

  # file-type colors in dircolors format. eza reads LS_COLORS too, so this one
  # attrset drives ls, grep, fd and eza's shared keys.
  fileTypes = {
    no = fg a.fg;
    fi = fg a.fg;
    di = "1;${fg a.blueBright}";
    ln = fg a.aquaBright;
    or = fg a.redBright;
    mi = fg a.redBright;
    ex = fg a.greenBright;
    pi = fg a.yellowBright;
    so = fg a.purpleBright;
    bd = fg a.yellow;
    cd = fg a.aquaBright;
    su = "1;${fg a.redBright}";
    sg = fg a.redBright;
    st = fg a.blue;
    ow = fg a.purpleBright;
    tw = "1;${fg a.purpleBright}";
  };

  # eza-only keys, layered on top of LS_COLORS by eza itself
  ezaExtra = {
    # mute the permission-bit chars (tw is owned by fileTypes above)
    ur = "0"; uw = "0"; ux = "0";
    gr = "0"; gw = "0"; gx = "0";
    tr = "0"; tx = "0";

    lp = fg a.aquaBright;   # symlink target path
    sn = fg a.yellowBright; # file size number
    sb = fg a.gray;         # file size unit
    da = fg a.blue;         # timestamp
    hd = "1;${fg a.purple}"; # table header

    im = fg a.greenBright;  # image
    vi = fg a.purple;       # video
    mu = fg a.aquaBright;   # music
    lo = fg a.aquaBright;   # lossless audio
    cr = fg a.redBright;    # crypto
    do = fg a.blueBright;   # document
    co = fg a.yellowBright; # compressed
    tm = fg a.gray;         # temp file
  };
in
{
  home.packages = with pkgs; [
    eza
  ];

  programs.fish = {
    enable = true;

    loginShellInit = ''
      if test (tty) = /dev/tty1; and not set -q NIRI_SESSION_STARTED
        set -gx NIRI_SESSION_STARTED 1
        exec niri-session
      end
    '';

    plugins = [
      {
        name = "done";
        src = pkgs.fishPlugins.done.src;
      }
    ];

    shellAliases = {
      # nixos aliases
      rebuild = "sudo nixos-rebuild switch --flake /home/anirudh/nixos#nixos";
      collect-garbage = "sudo nix-collect-garbage --delete-older-than 7d";

      # eza listings
      ls = "eza --icons --color=always --group-directories-first";
      lsa = "eza -al --icons --color=always --group-directories-first";
      la = "eza -a --icons --color=always --group-directories-first";
      ll = "eza -l --icons --color=always --group-directories-first";
      tree = "eza -aT --color=always --icons --git-ignore";
      tree-git = "eza -aT --color=always --icons";
      "l." = "eza -a | grep -e '^\\.'";

      # navigation
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";

      # utilities
      grep = "grep --color=auto";
      tarnow = "tar -acf ";
      untar = "tar -zxvf ";
      wget = "wget -c ";
      psmem = "ps auxf | sort -nr -k 4";
      psmem10 = "ps auxf | sort -nr -k 4 | head -10";
      jctl = "journalctl -p 3 -xb";
      tb = "nc termbin.com 9999";

      # other
      emacs = ''emacsclient -nw -a ""'';
      emacsg = ''emacsclient -c -n -a ""'';
      timer = "timr-tui";
    };

    functions = {
      fish_greeting = "";

      history = ''
        builtin history --show-time='%F %T ' $argv
      '';

      backup = {
        argumentNames = "filename";
        body = "cp $filename $filename.bak";
      };

      copy = ''
        set count (count $argv | tr -d \n)
        if test "$count" = 2; and test -d "$argv[1]"
            set from (echo $argv[1] | string trim --right --chars=/)
            set to (echo $argv[2])
            command cp -r $from $to
        else
            command cp $argv
        end
      '';

      # !! and !$ support (from oh-my-fish/plugin-bang-bang)
      __history_previous_command = ''
        switch (commandline -t)
        case "!"
          commandline -t $history[1]; commandline -f repaint
        case "*"
          commandline -i !
        end
      '';

      __history_previous_command_arguments = ''
        switch (commandline -t)
        case "!"
          commandline -t ""
          commandline -f history-token-search-backward
        case "*"
          commandline -i '$'
        end
      '';
    };

    interactiveShellInit = ''
      set -g fish_autosuggestion_enabled 0

      # done plugin: notify for commands longer than 10s
      set -U __done_min_cmd_duration 10000
      set -U __done_notification_urgency_level low

      # !! and !$ key bindings
      if [ "$fish_key_bindings" = fish_vi_key_bindings ]
        bind -Minsert ! __history_previous_command
        bind -Minsert '$' __history_previous_command_arguments
      else
        bind ! __history_previous_command
        bind '$' __history_previous_command_arguments
      end

      # ${config.theme.name} file colors, shared by ls/grep/fd and eza
      set -gx LS_COLORS "${render fileTypes}"
      set -gx EZA_COLORS "${render ezaExtra}"
    '';
  };
}

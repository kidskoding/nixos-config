{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  c = config.lib.stylix.colors;
  fg = n: "38;2;${c."${n}-rgb-r"};${c."${n}-rgb-g"};${c."${n}-rgb-b"}";

  render = attrs: lib.concatStringsSep ":" (lib.mapAttrsToList (k: v: "${k}=${v}") attrs);

  # file-type colors in dircolors format. eza reads LS_COLORS too, so this one
  # attrset drives ls, grep, fd and eza's shared keys.
  fileTypes = {
    no = fg "base05";
    fi = fg "base05";
    di = "1;${fg "base0D"}";
    ln = fg "base0C";
    or = fg "base08";
    mi = fg "base08";
    ex = fg "base0B";
    pi = fg "base0A";
    so = fg "base0E";
    bd = fg "base0A";
    cd = fg "base0C";
    su = "1;${fg "base08"}";
    sg = fg "base08";
    st = fg "base0D";
    ow = fg "base0E";
    tw = "1;${fg "base0E"}";
  };

  # eza-only keys, layered on top of LS_COLORS by eza itself
  ezaExtra = {
    # mute the permission-bit chars (tw is owned by fileTypes above)
    ur = "0";
    uw = "0";
    ux = "0";
    gr = "0";
    gw = "0";
    gx = "0";
    tr = "0";
    tx = "0";

    lp = fg "base0C"; # symlink target path
    sn = fg "base0A"; # file size number
    sb = fg "base04"; # file size unit
    da = fg "base0D"; # timestamp
    hd = "1;${fg "base0E"}"; # table header

    im = fg "base0B"; # image
    vi = fg "base0E"; # video
    mu = fg "base0C"; # music
    lo = fg "base0C"; # lossless audio
    cr = fg "base08"; # crypto
    do = fg "base0D"; # document
    co = fg "base0A"; # compressed
    tm = fg "base04"; # temp file
  };
in {
  imports = [inputs.sops-nix.homeManagerModules.sops];

  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    age.keyFile = "/home/anirudh/.config/sops/age/keys.txt";
  };

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
      rebuild = "/home/anirudh/nixos/scripts/rebuild.sh";
      nvim-sync = "/home/anirudh/nixos/scripts/nvim-sync.sh";
      devshell = "/home/anirudh/nixos/scripts/devshell.sh";
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
      agent = "cursor-agent";
      timer = "timr-tui";
      vim = "nvim";
      vi = "nvim";
    };

    functions = {
      fish_greeting = ''
        printf '%s\n\n— %s' \
          "Every great thing that you will ever achieve is built brick by brick, day by day. You cannot lose if you just don't give up!" \
          'Nicholas "Jynxzi" Stewart' \
          | fold -s -w 40 | cowsay -n -f stegosaurus
      '';

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

      # ${c.scheme} file colors, shared by ls/grep/fd and eza
      set -gx LS_COLORS "${render fileTypes}"
      set -gx EZA_COLORS "${render ezaExtra}"
    '';
  };
}

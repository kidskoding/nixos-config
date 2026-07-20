{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    eza
  ];

  programs.fish = {
    enable = true;

    loginShellInit = ''
      # auto-start hyprland when logging in on tty1
      if uwsm check may-start
        exec uwsm start hyprland-uwsm.desktop
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

      # catppuccin mocha eza colors
      set -gx EZA_COLORS "ur=0:uw=0:ux=0:gr=0:gw=0:gx=0:tr=0:tw=0:tx=0:no=38;2;${config.theme.ansi.fg}:fi=38;2;${config.theme.ansi.fg}:di=1;38;2;${config.theme.ansi.blueBright}:ln=38;2;${config.theme.ansi.aquaBright}:lp=38;2;${config.theme.ansi.aquaBright}:or=38;2;${config.theme.ansi.redBright}:mi=38;2;${config.theme.ansi.redBright}:ex=38;2;${config.theme.ansi.greenBright}:pi=38;2;${config.theme.ansi.yellowBright}:so=38;2;${config.theme.ansi.purpleBright}:bd=38;2;${config.theme.ansi.yellow}:cd=38;2;${config.theme.ansi.aquaBright}:su=1;38;2;${config.theme.ansi.redBright}:sg=38;2;${config.theme.ansi.redBright}:st=38;2;${config.theme.ansi.blue}:ow=38;2;${config.theme.ansi.purpleBright}:tw=1;38;2;${config.theme.ansi.purpleBright}:sn=38;2;${config.theme.ansi.yellowBright}:sb=38;2;${config.theme.ansi.gray}:da=38;2;${config.theme.ansi.blue}:hd=1;38;2;${config.theme.ansi.purple}:im=38;2;${config.theme.ansi.greenBright}:vi=38;2;${config.theme.ansi.purple}:mu=38;2;${config.theme.ansi.aquaBright}:lo=38;2;${config.theme.ansi.aquaBright}:cr=38;2;${config.theme.ansi.redBright}:do=38;2;${config.theme.ansi.blueBright}:co=38;2;${config.theme.ansi.yellowBright}:tm=38;2;${config.theme.ansi.gray}"
    '';
  };
}

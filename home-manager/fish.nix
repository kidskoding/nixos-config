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
      # rebuild system
      rebuild = "sudo nixos-rebuild switch --flake /home/anirudh/nixos#nixos";

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

      # Catppuccin Mocha eza colors
      set -gx EZA_COLORS "ur=0:uw=0:ux=0:gr=0:gw=0:gx=0:tr=0:tw=0:tx=0:no=38;2;205;214;244:fi=38;2;205;214;244:di=1;38;2;137;180;250:ln=38;2;137;220;235:lp=38;2;137;220;235:or=38;2;243;139;168:mi=38;2;243;139;168:ex=38;2;166;227;161:pi=38;2;250;179;135:so=38;2;245;194;231:bd=38;2;249;226;175:cd=38;2;148;226;213:su=1;38;2;235;160;172:sg=38;2;235;160;172:st=38;2;116;199;236:ow=38;2;180;190;254:tw=1;38;2;180;190;254:sn=38;2;250;179;135:sb=38;2;127;132;156:da=38;2;116;199;236:hd=1;38;2;203;166;247:im=38;2;166;227;161:vi=38;2;203;166;247:mu=38;2;148;226;213:lo=38;2;148;226;213:cr=38;2;243;139;168:do=38;2;137;180;250:co=38;2;250;179;135:tm=38;2;108;112;134"
    '';
  };
}

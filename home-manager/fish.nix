{ pkgs, ... }:

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
    '';
  };
}

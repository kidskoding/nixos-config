{...}: {
  flake.homeModules.kidskoding = {lib, ...}: let
    fd = "fd --hidden --follow --exclude .git";
  in {
    programs.fzf = {
      enable = true;
      enableFishIntegration = true;

      defaultCommand = "${fd} --type f";

      defaultOptions = [
        "--height=60%"
        "--layout=reverse"
        "--style=full"
        "--info=inline-right"
        "--prompt='❯ '"
        "--pointer=▌"
        "--marker=┃"
        "--scrollbar=│"
        "--highlight-line"
        "--cycle"
        "--ansi"
        "--preview-window=right,55%,border-rounded"
        "--bind=ctrl-/:toggle-preview"
      ];

      fileWidget = {
        command = "${fd} --type f";
        options = [
          "--border-label=' files '"
          "--preview='bat --color=always --style=numbers --theme=gruvbox-dark --line-range=:300 {}'"
        ];
      };

      changeDirWidget = {
        command = "${fd} --type d";
        options = [
          "--border-label=' dirs '"
          "--preview='eza -T -L2 --color=always --icons=always --group-directories-first {}'"
        ];
      };

      historyWidget.options = [
        "--border-label=' history '"
      ];

      colors = {
        bg = lib.mkForce "-1";
        gutter = "-1";
      };
    };
  };
}

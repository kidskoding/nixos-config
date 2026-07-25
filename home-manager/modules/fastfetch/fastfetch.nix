{ config, pkgs, ... }:

{
  programs.fastfetch = {
    enable = true;

    settings = {
      logo = {
        type = "small";
        color."1" = "38;2;137;180;250";
        padding = {
          top = 5;
          left = 4;
        };
      };

      display.separator = "  ";

      modules = [
        "break"
        {
          type = "title";
          keyWidth = 10;
          format = "               {6}{#38;2;137;180;250}@{#}{8}";
        }
        {
          type = "custom";
          format = " ────────────────────────────────────────── ";
        }
        {
          type = "os";
          key = "   󰻀";
          keyColor = "38;2;${config.theme.ansi.redBright}";
        }
        {
          type = "kernel";
          key = "   ";
          keyColor = "38;2;${config.theme.ansi.red}";
        }
        {
          type = "packages";
          key = "   󰏗";
          keyColor = "38;2;${config.theme.ansi.yellowBright}";
        }
        {
          type = "shell";
          key = "   ";
          keyColor = "38;2;${config.theme.ansi.yellow}";
        }
        {
          type = "host";
          key = "   ";
          keyColor = "38;2;${config.theme.ansi.greenBright}";
        }
        {
          type = "display";
          key = "   󰍹";
          keyColor = "38;2;${config.theme.ansi.green}";
        }
        {
          type = "wm";
          key = "   ";
          keyColor = "38;2;${config.theme.ansi.aquaBright}";
        }
        {
          type = "terminal";
          key = "   ";
          keyColor = "38;2;${config.theme.ansi.aqua}";
        }
        {
          type = "cpu";
          format = "{1}";
          key = "   ";
          keyColor = "38;2;${config.theme.ansi.blueBright}";
        }
        {
          type = "gpu";
          format = "{1} {2}";
          hideType = "integrated";
          key = "   ";
          keyColor = "38;2;${config.theme.ansi.blue}";
        }
        {
          type = "memory";
          key = "   󰍛";
          keyColor = "38;2;${config.theme.ansi.purpleBright}";
        }
        {
          type = "disk";
          key = "   󰋊";
          keyColor = "38;2;${config.theme.ansi.purple}";
        }
        /* {
          type = "localip";
          key = "   󰩟";
          format = "{1} ({4})";
          keyColor = "magenta";
        } */
        {
          type = "custom";
          format = " ────────────────────────────────────────── ";
        }
        "break"
      ];
    };
  };
}

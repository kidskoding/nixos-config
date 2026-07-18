{ config, pkgs, ... }:

{
  programs.fastfetch = {
    enable = true;

    settings = {
      logo = {
        type = "small";
        color."1" = "38;2;0;204;255";
        padding = {
          top = 4;
          left = 4;
        };
      };

      display.separator = "  ";

      modules = [
        "break"
        {
          type = "title";
          keyWidth = 10;
          format = "               {6}{7}{8}";
        }
        {
          type = "custom";
          format = " ────────────────────────────────────────── ";
        }
        {
          type = "os";
          key = "   󰻀";
          keyColor = "red";
        }
        {
          type = "kernel";
          key = "   ";
          keyColor = "yellow";
        }
        {
          type = "packages";
          key = "   󰏗";
          keyColor = "green";
        }
        {
          type = "host";
          key = "   ";
          keyColor = "cyan";
        }
        {
          type = "display";
          key = "   󰍹";
          keyColor = "blue";
        }
        {
          type = "wm";
          key = "   ";
          keyColor = "blue";
        }
        {
          type = "terminal";
          key = "   ";
          keyColor = "magenta";
        }
        {
          type = "cpu";
          format = "{1}";
          key = "   ";
          keyColor = "blue";
        }
        {
          type = "memory";
          key = "   󰍛";
          keyColor = "cyan";
        }
        {
          type = "disk";
          key = "   󰋊";
          keyColor = "green";
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

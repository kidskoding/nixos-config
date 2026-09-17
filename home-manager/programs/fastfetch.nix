{ config, pkgs, ... }:

let
  nixosBlue = "38;2;82;119;195";
  nixosBlueLight = "38;2;126;186;228";
in
{
  programs.fastfetch = {
    enable = true;

    settings = {
      logo = {
        type = "small";
        color = {
          "1" = nixosBlue;
          "2" = nixosBlueLight;
          "3" = nixosBlue;
          "4" = nixosBlueLight;
          "5" = nixosBlue;
          "6" = nixosBlueLight;
        };
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
          format = "               {6}{7}{8}";
          color = {
            user = nixosBlueLight;
            at = nixosBlueLight;
            host = nixosBlueLight;
          };
        }
        {
          type = "custom";
          format = " ────────────────────────────────────────── ";
        }
        {
          type = "os";
          key = "   󰻀";
          keyColor = "38;2;${config.theme.ansi.red}";
        }
        {
          type = "kernel";
          key = "   ";
          keyColor = "38;2;${config.theme.ansi.redBright}";
        }
        {
          type = "packages";
          key = "   󰏗";
          keyColor = "38;2;${config.theme.ansi.yellow}";
        }
        {
          type = "shell";
          key = "   ";
          keyColor = "38;2;${config.theme.ansi.yellowBright}";
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

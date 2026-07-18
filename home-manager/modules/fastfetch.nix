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
          format = "               {6}{7}{8}";
        }
        {
          type = "custom";
          format = " ────────────────────────────────────────── ";
        }
        {
          type = "os";
          key = "   󰻀";
          keyColor = "38;2;243;139;168";
        }
        {
          type = "kernel";
          key = "   ";
          keyColor = "38;2;250;179;135";
        }
        {
          type = "packages";
          key = "   󰏗";
          keyColor = "38;2;249;226;175";
        }
        {
          type = "host";
          key = "   ";
          keyColor = "38;2;166;227;161";
        }
        {
          type = "display";
          key = "   󰍹";
          keyColor = "38;2;148;226;213";
        }
        {
          type = "wm";
          key = "   ";
          keyColor = "38;2;137;220;235";
        }
        {
          type = "terminal";
          key = "   ";
          keyColor = "38;2;116;199;236";
        }
        {
          type = "cpu";
          format = "{1}";
          key = "   ";
          keyColor = "38;2;137;180;250";
        }
        {
          type = "gpu";
          format = "{1} {2}";
          hideType = "integrated";
          key = "   ";
          keyColor = "38;2;180;190;254";
        }
        {
          type = "memory";
          key = "   󰍛";
          keyColor = "38;2;203;166;247";
        }
        {
          type = "disk";
          key = "   󰋊";
          keyColor = "38;2;245;194;231";
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

{ config, pkgs, ... }:

let
  c = config.theme.colors;
in
{
  programs.alacritty = {
    enable = true;

    settings = {
      general = {
        live_config_reload = true;
      };

      env = {
        TERM = "xterm-256color";
      };

      window = {
        dynamic_padding = true;
        title = "alacritty";
        opacity = 0.8;
        blur = true;

        padding.x = 5;

        dimensions = {
          columns = 100;
          lines = 30;
        };
      };

      font = {
        size = 15;

        normal = {
          family = config.theme.fontFamily;
          style = "Regular";
        };

        # bold = {
        #   family = config.theme.fontFamily;
        #   style = "Regular";
        # };

        # italic = {
        #   family = config.theme.fontFamily;
        #   style = "Regular";
        # };
      };

      scrolling = {
        history = 10000;
        multiplier = 3;
      };

      selection = {
        semantic_escape_chars = ",│`|:\"' ()[]{}<>\t";
        save_to_clipboard = true;
      };

      cursor = {
        style = "Block";
        thickness = 0.15;
        unfocused_hollow = true;
      };

      mouse = {
        hide_when_typing = true;
        bindings = [
          { mouse = "Middle"; action = "PasteSelection"; }
        ];
      };

      keyboard.bindings = [
        { key = "V"; mods = "Control|Shift"; action = "Paste"; }
        { key = "C"; mods = "Control|Shift"; action = "Copy"; }
        { key = "F"; mods = "Control|Shift"; action = "SearchForward"; }
        { key = "B"; mods = "Control|Shift"; action = "SearchBackward"; }
        { key = "Key0"; mods = "Control"; action = "ResetFontSize"; }
        { key = "PageUp"; mods = "Shift"; action = "ScrollPageUp"; }
        { key = "PageDown"; mods = "Shift"; action = "ScrollPageDown"; }
        { key = "Return"; mods = "Shift"; chars = "\r"; }
      ];

      colors = {
        primary = {
          background = c.bg;
          foreground = c.fg;
        };

        normal = {
          black = c.black;
          red = c.red;
          green = c.green;
          yellow = c.yellow;
          blue = c.blue;
          magenta = c.purple;
          cyan = c.aqua;
          white = c.gray;
        };

        bright = {
          black = c.grayBright;
          red = c.redBright;
          green = c.greenBright;
          yellow = c.yellowBright;
          blue = c.blueBright;
          magenta = c.purpleBright;
          cyan = c.aquaBright;
          white = c.fgBright;
        };
      };
    };
  };
}

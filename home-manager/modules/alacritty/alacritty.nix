{ config, pkgs, ... }:

let
  theme = builtins.fromTOML (builtins.readFile (../../themes + "/${config.theme.name}.toml"));
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
        WINIT_X11_SCALE_FACTOR = "1";
      };

      window = {
        dynamic_padding = true;
        title = "alacritty";
        opacity = 0.8;
        blur = true;

        padding.x = 10;

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

        # GohuFont has no real bold/italic faces, so bold/italic just fall
        # back to normal anyway. Left here commented in case the font changes.
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

      colors = theme.colors;
    };
  };
}

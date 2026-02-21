{ ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      general = {
        import = [ "~/.config/alacritty/themes/Gruvbox-Dark.toml" ];
	live_config_reload = true;
      };
      env = {
        TERM = "xterm-256color";
        WINIT_X11_SCALE_FACTOR = "1";
      };
      window = {
        dynamic_padding = true;
        decorations = "none";
        title = "Alacritty";
        opacity = 0.8;
        dimensions = {
          columns = 100;
          lines = 30;
        };
      };
      font = {
        size = 12;
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Italic";
        };
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
        style = "Underline";
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
      ];
    };
  };
  
  xdg.configFile."alacritty/themes/Gruvbox-Dark.toml".source = ./themes/Gruvbox-Dark.toml;
}

{config, ...}: let
  c = config.theme.colors;
in {
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      term = "xterm-256color";

      window-decoration = false;
      background-opacity = 0.8;
      background-blur = true;
      window-padding-x = 5;
      window-padding-balance = true;
      window-width = 100;
      window-height = 30;

      font-family = config.theme.fontFamily;
      font-size = 16;

      mouse-scroll-multiplier = 3;
      mouse-hide-while-typing = true;

      selection-word-chars = ",│`|:\"' ()[]{}<>\t,";
      copy-on-select = "clipboard";

      cursor-style = "block";
      cursor-style-blink = false;

      # ctrl+shift+c/v, ctrl+shift+f, ctrl+0, shift+pageup/down are defaults
      keybind = [
        "ctrl+shift+b=navigate_search:previous"
        "shift+enter=text:\\r"
      ];

      theme = "nix";
    };

    themes.nix = {
      background = c.bg;
      foreground = c.fg;
      palette = [
        "0=${c.black}"
        "1=${c.red}"
        "2=${c.green}"
        "3=${c.yellow}"
        "4=${c.blue}"
        "5=${c.purple}"
        "6=${c.aqua}"
        "7=${c.gray}"
        "8=${c.grayBright}"
        "9=${c.redBright}"
        "10=${c.greenBright}"
        "11=${c.yellowBright}"
        "12=${c.blueBright}"
        "13=${c.purpleBright}"
        "14=${c.aquaBright}"
        "15=${c.fgBright}"
      ];
    };
  };
}

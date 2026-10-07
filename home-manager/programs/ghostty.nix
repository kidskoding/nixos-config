{
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      term = "xterm-256color";

      background-blur = true;

      confirm-close-surface = false;

      window-decoration = false;
      # window-padding-x = 5;
      window-padding-balance = true;
      window-width = 100;
      window-height = 30;

      mouse-scroll-multiplier = 3;
      mouse-hide-while-typing = true;

      resize-overlay = "never";

      selection-word-chars = ",│`|:\"' ()[]{}<>\t,";
      copy-on-select = "clipboard";
      app-notifications = false;

      cursor-style = "block";
      cursor-style-blink = false;
      shell-integration-features = "no-cursor";

      # ctrl+shift+c/v, ctrl+shift+f, ctrl+0, shift+pageup/down are defaults
      keybind = [
        "ctrl+shift+b=navigate_search:previous"
        "shift+enter=text:\\r"
      ];
    };
  };
}

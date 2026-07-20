{ config, ... }:

{
  programs.wofi = {
    enable = true;

    settings = {
      "matching-mode" = "fuzzy";
      allow_images = true;
      image_size = 32;
      mode = "drun";
      hide_scroll = true;
      insensitive = true;
      gtk_dark = true;
    };

    style = builtins.replaceStrings
      [ "@font-family@" "@color-bg@" "@color-bg-alt@" "@color-fg@" "@color-blue@" "@color-yellow@" ]
      [ config.theme.fontFamily config.theme.colors.bg config.theme.colors.bgAlt config.theme.colors.fg config.theme.colors.blueBright config.theme.colors.yellowBright ]
      (builtins.readFile ./style.css);
  };
}

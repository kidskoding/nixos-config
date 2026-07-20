{ config, ... }:

{
  services.mako = {
    enable = true;

    settings = {
      font = "${config.theme.fontFamily} 16";

      sort = "-priority";
      layer = "overlay";
      anchor = "top-right";
      margin = "40,30,0,0";

      width = 350;
      height = 100;
      max-visible = 5;

      border-size = 2;
      border-color = config.theme.colors.blueBright;
      border-radius = 10;

      background-color = config.theme.colors.bg;
      text-color = config.theme.colors.fg;
      progress-color = "over ${config.theme.colors.bgAlt}";

      padding = 8;

      format = "<b>%a:</b> %s\\n%b";

      default-timeout = 10000;

      "urgency=low" = {
        background-color = config.theme.colors.bg;
        text-color = config.theme.colors.gray;
        border-color = config.theme.colors.bgAlt;
        default-timeout = 10000;
      };

      "urgency=normal" = {
        background-color = config.theme.colors.bg;
        text-color = config.theme.colors.fg;
        border-color = config.theme.colors.blueBright;
        default-timeout = 10000;
      };

      "urgency=high" = {
        background-color = config.theme.colors.bg;
        text-color = config.theme.colors.redBright;
        border-color = config.theme.colors.redBright;
        default-timeout = 0;
      };

      "app-name=Spotify summary=\"Now playing\"" = {
        background-color = config.theme.colors.bg;
        text-color = config.theme.colors.gray;
        border-color = config.theme.colors.bgAlt;
        default-timeout = 10000;
      };
    };
  };
}

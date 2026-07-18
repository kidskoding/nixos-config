{ ... }:

{
  services.mako = {
    enable = true;

    settings = {
      font = "JetBrainsMono Nerd Font 11";

      sort = "-priority";
      layer = "overlay";
      anchor = "top-right";
      margin = "40,30,0,0";

      width = 300;
      height = 100;
      max-visible = 5;

      border-size = 2;
      border-color = "#89b4fa";
      border-radius = 10;

      background-color = "#1e1e2e";
      text-color = "#cdd6f4";
      progress-color = "over #313244";

      padding = 8;

      format = "<b>%a:</b> %s\\n%b";

      default-timeout = 10000;

      "urgency=low" = {
        background-color = "#1e1e2e";
        text-color = "#6c7086";
        border-color = "#313244";
        default-timeout = 10000;
      };

      "urgency=normal" = {
        background-color = "#1e1e2e";
        text-color = "#cdd6f4";
        border-color = "#89b4fa";
        default-timeout = 10000;
      };

      "urgency=high" = {
        background-color = "#1e1e2e";
        text-color = "#f38ba8";
        border-color = "#f38ba8";
        default-timeout = 0;
      };

      "app-name=Spotify summary=\"Now playing\"" = {
        background-color = "#1e1e2e";
        text-color = "#6c7086";
        border-color = "#313244";
        default-timeout = 10000;
      };
    };
  };
}

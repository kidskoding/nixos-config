{ ... }:

{
  programs.niri.settings.window-rules = [
    {
      draw-border-with-background = false;
      clip-to-geometry = true;
      open-fullscreen = false;
      geometry-corner-radius = {
        top-left = 8.0;
        top-right = 8.0;
        bottom-left = 8.0;
        bottom-right = 8.0;
      };
    }
    {
      matches = [ { is-active = false; } ];
      opacity = 0.95;
    }
    {
      matches = [
        { app-id = "^discord$"; }
        { app-id = "^zen-beta$"; }
        { app-id = "^spotify$"; }
      ];
      default-column-width.proportion = 1.0;
    }
    {
      matches = [
        {
          app-id = "^steam$";
          title = "^notificationtoasts_[0-9]+_desktop$";
        }
      ];
      default-floating-position = {
        x = 10;
        y = 10;
        relative-to = "bottom-right";
      };
    }
    {
      matches = [
        { app-id = "^steam_app_.*$"; }
        { app-id = "^gamescope$"; }
      ];
      open-fullscreen = true;
      variable-refresh-rate = true;
    }
  ];
}

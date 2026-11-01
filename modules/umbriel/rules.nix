{...}: {
  flake.homeModules.umbriel = {
    config,
    lib,
    ...
  }: {
    programs.umbriel.settings.window_rule = [
      {
        match.is_focused = false;
        opacity = 0.95;
      }
      {
        match.app_id = "^discord$";
        default_maximize = true;
      }
      {
        match = {
          app_id = "^steam$";
          title = "^notificationtoasts_[0-9]+_desktop$";
        };
        default_position = {
          x = 10;
          y = 10;
          anchor = "bottom_right";
        };
      }
      (
        {
          match.app_id = [
            "^steam_app_.*$"
            "^gamescope$"
          ];
          default_fullscreen = true;
        }
        // lib.optionalAttrs config.my.display.vrr {vrr = "always";}
      )
    ];
  };
}

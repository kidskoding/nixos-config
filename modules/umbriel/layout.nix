{...}: {
  flake.homeModules.umbriel = {config, ...}: let
    c = config.lib.stylix.colors.withHashtag;
  in {
    programs.umbriel.settings = {
      layout = {
        mode = "scrolling";
        gap = 6;
        struts.top = 3;
        extent_presets = [
          0.33333
          0.5
          0.66667
          1.0
        ];

        scrolling = {
          center_focused = "on_overflow";
          default_extent_fraction = 0.5;
        };
      };

      appearance = {
        border_width = 2;
        corner_radius = 8;

        shadow = {
          enabled = true;
          softness = 20;
          offset_x = 0;
          offset_y = 5;
        };
      };

      colors = {
        border = {
          focused = c.base0D;
          unfocused = c.base01;
        };
        shadow = "${c.base00}ee";
      };
    };
  };
}

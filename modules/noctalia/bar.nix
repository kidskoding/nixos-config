{...}: {
  flake.homeModules.noctalia = {config, ...}: let
    d = config.my.display;
    narrow = d.width / d.scale < 1920;
  in {
    programs.noctalia.settings = {
      bar = {
        main = {
          position = "top";
          margin_edge = 10;
          margin_ends = 6;
          thickness = 44;
          radius = 16;
          padding = 12;
          widget_spacing = 12;
          scale =
            if narrow
            then 1.0
            else 1.1;
          font_scale =
            if narrow
            then 1.0
            else 1.1;
          background_opacity = 0.8;
          compositor_blur = true;
          capsule = true;
          capsule_fill = "surface_container";
          color = "on_surface";
          capsule_border_width = 0;
          capsule_padding = 8;
          capsule_thickness = 0.8;
          start =
            if narrow
            then ["control-center" "umbriel" "workspaces" "media"]
            else ["control-center" "umbriel" "workspaces"];
          center =
            if narrow
            then []
            else ["media"];
          end = [
            "tray"
            "network"
            "bluetooth"
            "volume"
            "brightness"
            "battery"
            "clock"
            "session"
          ];
          dead_zone = {
            actions = {
              right = "none";
            };
          };
        };
      };
      widget = {
        tray = {
          drawer = true;
        };
        workspaces = {
          capsule = false;
          style = "regular";
          capsule_radius = 0;
          scale = 1.5;
          font_weight = 700;
          active_pill_size = 1;
          inactive_pill_size = 1;
          label_source = "id";
          hide_when_empty = true;
        };
        umbriel = {
          type = "noctalia/umbriel-companion:bar";
          show_layout_name = true;
        };
        media = {
          artist_first = false;
          max_length = 275;
          title_scroll = "always";
          hide_when_no_media = true;
          show_progress = true;
        };
        volume = {
          show_label = true;
          icon_color = "magenta";
          mute_color = "red";
        };
        network = {
          show_label = true;
          show_vpn_label = false;
          icon_color = "cyan";
        };
        bluetooth = {
          show_label = true;
          icon_color = "blue";
        };
        brightness = {
          show_label = true;
          icon_color = "yellow";
        };
        battery = {
          display_mode = "glyph";
          show_label = true;
          icon_color = "green";
          warning_color = "yellow";
        };
        clock = {
          format = "<span foreground='@red'></span> {:%a %b %d} | <span foreground='@red'></span> {:%I:%M %p}";
          tooltip_format = "{:%A, %B %-d %Y}";
          actions = {
            left = "panel-toggle control-center calendar";
            right = "panel-toggle control-center calendar";
          };
        };
        control-center = {
          capsule = true;
          custom_image = "/run/current-system/sw/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          custom_image_colorize = false;
        };
        session = {
          glyph = "shutdown";
          capsule = true;
          capsule_fill = "error";
          icon_color = "on_error";
          actions = {
            left = "panel-toggle session";
          };
        };
      };
    };
  };
}

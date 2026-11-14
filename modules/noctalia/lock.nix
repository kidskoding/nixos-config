{...}: {
  flake.homeModules.noctalia = {config, ...}: let
    output = config.my.display.output;
  in {
    programs.noctalia.settings = {
      idle = {
        behavior_order = [
          "lock"
          "screen-off"
          "suspend"
        ];
        behavior = {
          lock = {
            enabled = true;
            timeout = 300;
            action = "lock";
          };
          screen-off = {
            enabled = true;
            timeout = 330;
            action = "screen_off";
          };
          suspend = {
            enabled = true;
            timeout = 900;
            action = "lock_and_suspend";
          };
        };
      };
      lockscreen = {
        transition = [];
      };
      lockscreen_widgets = {
        enabled = true;
        widget = {
          "lockscreen-login-box@${output}" = {
            type = "login_box";
            inherit output;
            cx = 960.0;
            cy = 540.0;
            placement_width = 1920.0;
            placement_height = 1080.0;
            settings = {
              background_opacity = 1.0;
              show_unlock_hint = false;
              center_password_text = true;
              show_media = false;
              show_weather = false;
              show_clock = true;
              show_battery = true;
              show_user = true;
              show_caps_lock = true;
              show_keyboard_layout = true;
            };
          };
          "lockscreen-media@${output}" = {
            type = "media_player";
            inherit output;
            cx = 960.0;
            cy = 800.0;
            placement_width = 1920.0;
            placement_height = 1080.0;
            settings = {
              background_opacity = 1.0;
              hide_when_no_media = true;
              show_progress = true;
            };
          };
          "lockscreen-visualizer@${output}" = {
            type = "audio_visualizer";
            inherit output;
            cx = 960.0;
            cy = 960.0;
            placement_width = 1920.0;
            placement_height = 1080.0;
            box_width = 600.0;
            box_height = 100.0;
            settings = {
              show_when_idle = false;
              background = false;
            };
          };
        };
      };
    };
  };
}

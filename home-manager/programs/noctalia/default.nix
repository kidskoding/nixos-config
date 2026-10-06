{
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.noctalia.homeModules.default

    ./bar.nix
    ./colors.nix
    ./launcher.nix
    ./lock.nix
    ./notifications.nix
  ];

  programs.noctalia = {
    enable = true;

    settings = {
      accessibility.ui_scale = 1.2;
      osd.kinds.media = false;
      plugins.enabled = ["noctalia/timer"];

      control_center.sidebar_section = "none";

      shell = {
        font_family = config.theme.fontFamily;
        time_format = "{:%-I:%M %p}";
        avatar_path = "${./avatars/starfire.jpeg}";
        panel = {
          open_near_click_control_center = true;
          session_placement = "floating";
          session_position = "center";
          open_near_click_session = false;
          open_near_click_wallpaper = true;
        };
      };

      location.auto_locate = true;

      weather = {
        enabled = true;
        unit = "imperial";
      };

      battery.warning_threshold = 30;

      dock.enabled = false;
    };
  };
}

{inputs, ...}: {
  flake.homeModules.niri = {
    lib,
    pkgs,
    ...
  }: let
    terminal = "ghostty";
  in {
    # gui helpers live in nixosModules.niri
    home.packages = with pkgs; [
      adwaita-icon-theme
      brightnessctl
      cliphist
      grim
      libnotify
      playerctl
      slurp
      wl-clipboard
      wl-mirror

      kdePackages.qtsvg
    ];

    programs.niri.settings = {
      prefer-no-csd = true;
      screenshot-path = "~/Pictures/Screenshots/%Y-%m-%dT%H:%M:%S.png";
      hotkey-overlay.skip-at-startup = true;

      xwayland-satellite.path =
        lib.getExe pkgs.xwayland-satellite-unstable;

      environment = {
        NIXOS_OZONE_WL = "1";
        GDK_BACKEND = "wayland,x11,*";
        QT_QPA_PLATFORM = "wayland;xcb";
        SDL_VIDEODRIVER = "wayland";
        CLUTTER_BACKEND = "wayland";
        QT_AUTO_SCREEN_SCALE_FACTOR = "0";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        GDK_SCALE = "1";
        MOZ_ENABLE_WAYLAND = "1";
        TERMINAL = terminal;
      };

      input = {
        keyboard.xkb.layout = "us";
        focus-follows-mouse.enable = true;

        touchpad = {
          tap = true;
          dwt = true;
          natural-scroll = false;
          accel-profile = "flat";
        };

        mouse.accel-profile = "flat";
      };

      spawn-at-startup = [
        {argv = ["noctalia"];}
        {
          argv = [
            "nm-applet"
            "--indicator"
          ];
        }
        {sh = "wl-paste --watch cliphist store";}
        {argv = [terminal];}
      ];
    };
  };
}

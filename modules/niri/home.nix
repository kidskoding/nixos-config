{...}: {
  flake.homeModules.niri = {
    inputs,
    lib,
    pkgs,
    ...
  }: let
    terminal = "ghostty";
  in {
    # gui helpers live in nixosModules.niri; victus gets them from apt
    home.packages = with pkgs; [
      adwaita-icon-theme
      brightnessctl
      grim
      libnotify
      playerctl
      slurp

      kdePackages.qtsvg
    ];

    # niri's own portals.conf sends FileChooser to gnome (gtk dialog).
    # user config wins over the system file, so re-point just FileChooser at kde.
    xdg.configFile."xdg-desktop-portal/niri-portals.conf".text = ''
      [preferred]
      default=gnome;gtk;
      org.freedesktop.impl.portal.Access=gtk;
      org.freedesktop.impl.portal.FileChooser=kde;
      org.freedesktop.impl.portal.Notification=gtk;
      org.freedesktop.impl.portal.Secret=gnome-keyring;
    '';

    programs.fish.loginShellInit = ''
      if test (tty) = /dev/tty1; and not set -q NIRI_SESSION_STARTED
        set -gx NIRI_SESSION_STARTED 1
        exec niri-session
      end
    '';

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

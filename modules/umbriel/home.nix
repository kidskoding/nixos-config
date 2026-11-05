{...}: {
  flake.homeModules.umbriel = {pkgs, ...}: let
    terminal = "ghostty";
  in {
    # gui helpers live in nixosModules.umbriel
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

    # user config wins over the system file, so re-point just FileChooser at kde.
    xdg.configFile."xdg-desktop-portal/umbriel-portals.conf".text = ''
      [preferred]
      default=umbriel;gtk;
      org.freedesktop.impl.portal.Access=gtk;
      org.freedesktop.impl.portal.FileChooser=kde;
      org.freedesktop.impl.portal.Notification=gtk;
      org.freedesktop.impl.portal.Secret=gnome-keyring;
    '';

    programs.fish.loginShellInit = ''
      if test (tty) = /dev/tty1; and not set -q UMBRIEL_SESSION_STARTED
        set -gx UMBRIEL_SESSION_STARTED 1
        exec start-umbriel
      end
    '';

    programs.umbriel.enable = true;
    programs.umbriel.settings = {
      general = {
        show_cheatsheet = false;
        autostart = [
          "noctalia"
          "nm-applet --indicator"
          "wl-paste --watch cliphist store"
          terminal
        ];
      };

      appearance.prefer_no_csd = true;

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
        keyboard.layout = "us";
        focus.follows_mouse = true;

        touchpad = {
          tap = true;
          disable_while_typing = true;
          natural_scroll = false;
          accel_profile = "flat";
        };

        mouse.accel_profile = "flat";
      };
    };
  };
}

{
  inputs,
  self,
  ...
}: let
  overlays = [
    (final: prev: {
      libdisplay-info_0_2 = prev.libdisplay-info.overrideAttrs (old: rec {
        version = "0.2.0";
        src = prev.fetchFromGitLab {
          domain = "gitlab.freedesktop.org";
          owner = "emersion";
          repo = "libdisplay-info";
          rev = version;
          hash = "sha256-6xmWBrPHghjok43eIDGeshpUEQTuwWLXNHg7CnBUt3Q=";
        };
      });
    })

    inputs.niri.overlays.niri
  ];
in {
  flake.nixosModules.niri = {
    config,
    pkgs,
    ...
  }: {
    imports = [inputs.niri.nixosModules.niri];

    home-manager.sharedModules = [
      self.homeModules.niri
      {
        home.packages = with pkgs; [
          blueman
          hyprpicker
          nautilus
          networkmanagerapplet
          qimgv
        ];
      }
    ];

    # niri!!!
    nixpkgs.overlays = overlays;

    programs.niri = {
      enable = true;
      package = pkgs.niri-unstable;
    };
    niri-flake.cache.enable = false;

    systemd.packages = [config.programs.niri.package];

    xdg.portal.extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  flake.homeModules.niri = {
    lib,
    pkgs,
    ...
  }: let
    terminal = "ghostty";
  in {
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

    programs.fish.loginShellInit = ''
      if test (tty) = /dev/tty1; and test "$XDG_SESSION_TYPE" = tty; and not set -q NIRI_SESSION_STARTED
        set -gx NIRI_SESSION_STARTED 1
        exec niri-session
      end
    '';

    programs.niri.settings = {
      prefer-no-csd = true;
      screenshot-path = "~/Pictures/Screenshots/%Y-%m-%dT%H:%M:%S.png";
      hotkey-overlay.skip-at-startup = true;

      outputs."eDP-1" = {
        position = {
          x = 0;
          y = 0;
        };
        scale = 1.2;
      };

      xwayland-satellite.path =
        lib.getExe pkgs.xwayland-satellite-unstable;

      environment = {
        GDK_BACKEND = "wayland,x11,*";
        QT_QPA_PLATFORM = "wayland;xcb";
        SDL_VIDEODRIVER = "wayland";
        CLUTTER_BACKEND = "wayland";
        QT_AUTO_SCREEN_SCALE_FACTOR = "0";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        GDK_SCALE = "1";
        TERMINAL = terminal;
      };

      input = {
        mod-key = "Alt";
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

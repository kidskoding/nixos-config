{ inputs, lib, pkgs, ... }:

let
  terminal = "alacritty";
in
{
  imports = [
    ./binds.nix
    ./hypridle.nix
    ./layout.nix
    ./rules.nix
  ];

  home.packages = with pkgs; [
    adwaita-icon-theme
    blueman
    brightnessctl
    hyprpicker
    libnotify
    networkmanagerapplet
    playerctl
    qimgv

    kdePackages.dolphin
    kdePackages.qtsvg
  ];

  programs.niri.settings = {
    prefer-no-csd = true;
    screenshot-path = "~/Pictures/Screenshots/%Y-%m-%dT%H:%M:%S.png";
    hotkey-overlay.skip-at-startup = true;

    xwayland-satellite.path =
      lib.getExe inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.xwayland-satellite-unstable;

    environment = {
      NIXOS_OZONE_WL = "1";
      GDK_BACKEND = "wayland,x11,*";
      QT_QPA_PLATFORM = "wayland;xcb";
      SDL_VIDEODRIVER = "wayland";
      CLUTTER_BACKEND = "wayland";
      QT_AUTO_SCREEN_SCALE_FACTOR = "0";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      GDK_SCALE = "1";
      GDK_DPI_SCALE = "1.25";
      QT_FONT_DPI = "120";
      MOZ_ENABLE_WAYLAND = "1";
    };

    cursor = {
      theme = "Adwaita";
      size = 32;
    };

    outputs."eDP-1" = {
      mode = {
        width = 1920;
        height = 1080;
        refresh = 144.0;
      };
      position = { x = 0; y = 0; };
      scale = 1.0;
      variable-refresh-rate = "on-demand";
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
      { argv = [ "noctalia-shell" ]; }
      { argv = [ "blueman-applet" ]; }
      { argv = [ "nm-applet" "--indicator" ]; }
      { sh = "wl-paste --watch cliphist store"; }
      { argv = [ terminal ]; }
    ];
  };
}

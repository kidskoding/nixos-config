{ config, inputs, lib, pkgs, ... }:

let
  terminal = "alacritty";
  fileManager = "dolphin";
  noctalia = c: [ "noctalia-shell" "ipc" "call" ] ++ c;

  wallpaper = ./wallpapers/starfire-bg.jpg;

  locked = cmd: { action.spawn = cmd; allow-when-locked = true; };

  workspaceNames = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" "10" ];
  workspaceKey = ws: if ws == "10" then "0" else ws;

  workspaceBinds = builtins.listToAttrs (builtins.concatMap (ws: [
    { name = "Mod+${workspaceKey ws}"; value.action.focus-workspace = ws; }
    { name = "Mod+Shift+${workspaceKey ws}"; value.action.move-column-to-workspace = ws; }
    { name = "Mod+Ctrl+${workspaceKey ws}"; value.action.move-column-to-workspace = [ { focus = false; } ws ]; }
  ]) workspaceNames);
in
{
  imports = [ ./hypridle.nix ];

  home.packages = with pkgs; [
    adwaita-icon-theme
    awww
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

    layout = {
      gaps = 10;
      background-color = config.theme.colors.bg;

      center-focused-column = "on-overflow";
      default-column-width.proportion = 0.5;
      preset-column-widths = [
        { proportion = 0.33333; }
        { proportion = 0.5; }
        { proportion = 0.66667; }
        { proportion = 1.0; }
      ];

      focus-ring.enable = false;

      border = {
        enable = true;
        width = 2;
        active.color = config.theme.colors.purple;
        inactive.color = config.theme.colors.bgAlt;
      };

      shadow = {
        enable = true;
        softness = 20;
        color = "${config.theme.colors.black}ee";
      };
    };

    workspaces = builtins.listToAttrs (map (ws: {
      name = if ws == "10" then "10" else "0${ws}";
      value.name = ws;
    }) workspaceNames);

    spawn-at-startup = [
      { argv = [ "awww-daemon" ]; }
      { sh = "sleep 2 && awww img --transition-type none ${wallpaper}"; }
      { argv = [ "noctalia-shell" ]; }
      { argv = [ "blueman-applet" ]; }
      { argv = [ "nm-applet" "--indicator" ]; }
      { sh = "wl-paste --watch cliphist store"; }
      { argv = [ terminal ]; }
    ];

    binds = workspaceBinds // {
      "Mod+Return".action.spawn = terminal;
      "Mod+E".action.spawn = fileManager;
      "Mod+D".action.spawn = noctalia [ "launcher" "toggle" ];
      "Mod+C".action.spawn = noctalia [ "launcher" "clipboard" ];
      "Mod+Shift+E".action.spawn = noctalia [ "sessionMenu" "toggle" ];
      "Mod+Shift+R".action.spawn-sh = "pkill -f 'bin/quickshel[l]'; sleep 0.3; noctalia-shell";
      "Mod+Ctrl+L".action.spawn = "hyprlock";
      "Mod+Shift+C".action.spawn = [ "hyprpicker" "-a" ];

      "Mod+Q".action.close-window = [ ];
      "Mod+M".action.quit = [ ];
      "Mod+O".action.toggle-overview = [ ];
      "Mod+W".action.toggle-column-tabbed-display = [ ];
      "Mod+F".action.maximize-column = [ ];
      "Mod+Shift+Space".action.toggle-window-floating = [ ];
      "Mod+Space".action.switch-focus-between-floating-and-tiling = [ ];
      "Mod+R".action.switch-preset-column-width = [ ];
      "Mod+Comma".action.consume-window-into-column = [ ];
      "Mod+Period".action.expel-window-from-column = [ ];

      "Mod+Tab".action.focus-window-down = [ ];
      "Mod+Shift+Tab".action.focus-window-up = [ ];

      "Mod+H".action.focus-column-left = [ ];
      "Mod+L".action.focus-column-right = [ ];
      "Mod+J".action.focus-window-down = [ ];
      "Mod+K".action.focus-window-up = [ ];
      "Mod+Left".action.focus-column-left = [ ];
      "Mod+Right".action.focus-column-right = [ ];
      "Mod+Down".action.focus-window-down = [ ];
      "Mod+Up".action.focus-window-up = [ ];

      "Mod+Shift+H".action.move-column-left = [ ];
      "Mod+Shift+L".action.move-column-right = [ ];
      "Mod+Shift+J".action.move-window-down = [ ];
      "Mod+Shift+K".action.move-window-up = [ ];
      "Mod+Shift+Left".action.move-column-left = [ ];
      "Mod+Shift+Right".action.move-column-right = [ ];
      "Mod+Shift+Down".action.move-window-down = [ ];
      "Mod+Shift+Up".action.move-window-up = [ ];

      "Print".action.screenshot-screen = [ ];
      "Mod+Shift+S".action.screenshot = [ ];

      "XF86AudioRaiseVolume" = locked [ "wpctl" "set-volume" "-l" "1.5" "@DEFAULT_AUDIO_SINK@" "5%+" ];
      "XF86AudioLowerVolume" = locked [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-" ];
      "XF86AudioMute" = locked [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle" ];
      "XF86AudioMicMute" = locked [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle" ];
      "XF86AudioPlay" = locked [ "playerctl" "play-pause" ];
      "XF86AudioPause" = locked [ "playerctl" "play-pause" ];
      "XF86AudioNext" = locked [ "playerctl" "next" ];
      "XF86AudioPrev" = locked [ "playerctl" "previous" ];
      "XF86MonBrightnessUp" = locked [ "brightnessctl" "set" "+5%" ];
      "XF86MonBrightnessDown" = locked [ "brightnessctl" "set" "5%-" ];
    };

    window-rules = [
      {
        draw-border-with-background = false;
        clip-to-geometry = true;
        open-fullscreen = false;
        geometry-corner-radius = {
          top-left = 8.0;
          top-right = 8.0;
          bottom-left = 8.0;
          bottom-right = 8.0;
        };
      }
      {
        matches = [ { is-active = false; } ];
        opacity = 0.95;
      }
      {
        matches = [
          { app-id = "^discord$"; }
          { app-id = "^firefox$"; }
        ];
        default-column-width.proportion = 1.0;
      }
      {
        matches = [
          { app-id = "^steam$"; }
          { app-id = "^heroic$"; }
          { app-id = "^net\\.lutris\\.Lutris$"; }
        ];
      }
      {
        matches = [
          { app-id = "^steam_app_.*$"; }
          { app-id = "^gamescope$"; }
        ];
        open-fullscreen = true;
        variable-refresh-rate = true;
      }
    ];
  };
}

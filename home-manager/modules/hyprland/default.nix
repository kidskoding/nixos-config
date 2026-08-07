{ config, pkgs, ... }:

let
  terminal = "alacritty";
  fileManager = "dolphin";
  noctalia = "noctalia-shell ipc call";
  menu = "${noctalia} launcher toggle";
  mainMod = "SUPER";
in
{
  imports = [ ./hypridle.nix ];

  home.packages = with pkgs; [
    adwaita-icon-theme
    awww
    blueman
    brightnessctl
    grimblast
    hyprpicker
    libnotify
    lxqt.lxqt-policykit
    networkmanagerapplet
    playerctl
    qimgv

    # kde packages
    kdePackages.dolphin
    kdePackages.qtsvg
  ];
 
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = false;

    configType = "hyprlang";

    extraConfig = ''
      submap = resize
      binde = , l, resizeactive, 10 0
      binde = , h, resizeactive, -10 0
      binde = , k, resizeactive, 0 -10
      binde = , j, resizeactive, 0 10
      binde = , right, resizeactive, 10 0
      binde = , left, resizeactive, -10 0
      binde = , up, resizeactive, 0 -10
      binde = , down, resizeactive, 0 10
      bind = , escape, submap, reset
      bind = , Return, submap, reset
      submap = reset
    '';

    settings = {
      monitor = "eDP-1, 1920x1080@144, 0x0, 1";

      "$terminal" = terminal;
      "$fileManager" = fileManager;
      "$menu" = menu;
      "$mainMod" = mainMod;

      exec = [
        "awww-daemon"
        "sleep 2 && awww img --transition-type none ~/.config/hypr/starfire-bg.jpg"
      ];

      exec-once = [
        "noctalia-shell"
        "blueman-applet"
        "lxqt-policykit-agent"
        "nm-applet --indicator"
        "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
        "hypridle"
        "dex -a -s /etc/xdg/autostart/:~/.config/autostart/"
        "wl-paste --watch cliphist store"
        "[workspace 1 silent] ${terminal}"
      ];

      env = [
        "XCURSOR_SIZE,32"
        "XCURSOR_THEME,Adwaita"
        "GDK_BACKEND,wayland,x11,*"
        "QT_QPA_PLATFORM,wayland;xcb"
        "SDL_VIDEODRIVER,wayland"
        "CLUTTER_BACKEND,wayland"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "QT_AUTO_SCREEN_SCALE_FACTOR,0"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "GDK_SCALE,1"
        "GDK_DPI_SCALE,1.25"
        "QT_FONT_DPI,120"
        "MOZ_ENABLE_WAYLAND,1"
      ];

      input = {
        kb_layout = "us";
        follow_mouse = 1;

        touchpad = {
          natural_scroll = false;
          disable_while_typing = true;
          "tap-to-click" = true;
        };

        sensitivity = 0;
        accel_profile = "flat";
      };

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        
        "col.active_border" = "rgba(${builtins.substring 1 6 config.theme.colors.purple}ff)";
        "col.inactive_border" = "rgba(${builtins.substring 1 6 config.theme.colors.bgAlt}ff)";
        
        layout = "dwindle";
        resize_on_border = true;

        allow_tearing = true;
      };

      decoration = {
        rounding = 8;

        blur = {
          enabled = true;
          size = 6;
          passes = 2;
          new_optimizations = true;
          xray = true;
          ignore_opacity = true;
        };

        shadow = {
          enabled = true;
          range = 20;
          render_power = 3;
          color = "rgba(${builtins.substring 1 6 config.theme.colors.black}ee)";
        };

        active_opacity = 1.0;
        inactive_opacity = 0.95;
      };

      animations = {
        enabled = true;

        bezier = [
          "wind, 0.05, 0.9, 0.1, 1.05"
          "winIn, 0.1, 1.1, 0.1, 1.0"
          "winOut, 0.3, -0.3, 0, 1"
          "liner, 1, 1, 1, 1"
        ];

        animation = [
          "windows, 1, 6, wind, slide"
          "windowsIn, 1, 6, winIn, slide"
          "windowsOut, 1, 5, winOut, slide"
          "windowsMove, 1, 5, wind, slide"
          "border, 1, 1, liner"
          "borderangle, 1, 30, liner, loop"
          "fade, 1, 10, default"
          "workspaces, 1, 5, wind"
        ];
      };

      dwindle = {
        preserve_split = true;
        force_split = 2;
        smart_split = false;
        smart_resizing = true;
      };

      master = {
        new_status = "master";
        new_on_top = false;
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
        vrr = 2;
      };

      bind = [
        "${mainMod}, RETURN, exec, ${terminal}"
        "${mainMod}, Q, killactive,"
        "${mainMod} SHIFT, Q, forcekillactive,"
        "${mainMod}, M, exit,"
        "${mainMod}, E, exec, ${fileManager}"
        "${mainMod} SHIFT, Space, togglefloating,"
        "${mainMod} SHIFT, Space, centerwindow,"
        "${mainMod}, D, exec, ${menu}"
        "${mainMod}, P, pseudo,"
        "${mainMod}, F, fullscreen, 0"
        "${mainMod} SHIFT, F, fullscreen, 1"

        "${mainMod}, W, togglegroup"
        "${mainMod}, Tab, changegroupactive, f"
        "${mainMod} SHIFT, Tab, changegroupactive, b"

        "${mainMod}, left, movefocus, l"
        "${mainMod}, right, movefocus, r"
        "${mainMod}, up, movefocus, u"
        "${mainMod}, down, movefocus, d"

        "${mainMod}, h, movefocus, l"
        "${mainMod}, l, movefocus, r"
        "${mainMod}, k, movefocus, u"
        "${mainMod}, j, movefocus, d"

        "${mainMod} SHIFT, left, movewindow, l"
        "${mainMod} SHIFT, right, movewindow, r"
        "${mainMod} SHIFT, up, movewindow, u"
        "${mainMod} SHIFT, down, movewindow, d"

        "${mainMod} SHIFT, h, movewindow, l"
        "${mainMod} SHIFT, l, movewindow, r"
        "${mainMod} SHIFT, k, movewindow, u"
        "${mainMod} SHIFT, j, movewindow, d"

        "${mainMod}, 1, workspace, 1"
        "${mainMod}, 2, workspace, 2"
        "${mainMod}, 3, workspace, 3"
        "${mainMod}, 4, workspace, 4"
        "${mainMod}, 5, workspace, 5"
        "${mainMod}, 6, workspace, 6"
        "${mainMod}, 7, workspace, 7"
        "${mainMod}, 8, workspace, 8"
        "${mainMod}, 9, workspace, 9"
        "${mainMod}, 0, workspace, 10"

        "${mainMod} SHIFT, 1, movetoworkspace, 1"
        "${mainMod} SHIFT, 2, movetoworkspace, 2"
        "${mainMod} SHIFT, 3, movetoworkspace, 3"
        "${mainMod} SHIFT, 4, movetoworkspace, 4"
        "${mainMod} SHIFT, 5, movetoworkspace, 5"
        "${mainMod} SHIFT, 6, movetoworkspace, 6"
        "${mainMod} SHIFT, 7, movetoworkspace, 7"
        "${mainMod} SHIFT, 8, movetoworkspace, 8"
        "${mainMod} SHIFT, 9, movetoworkspace, 9"
        "${mainMod} SHIFT, 0, movetoworkspace, 10"

        "${mainMod} CTRL, 1, movetoworkspacesilent, 1"
        "${mainMod} CTRL, 2, movetoworkspacesilent, 2"
        "${mainMod} CTRL, 3, movetoworkspacesilent, 3"
        "${mainMod} CTRL, 4, movetoworkspacesilent, 4"
        "${mainMod} CTRL, 5, movetoworkspacesilent, 5"
        "${mainMod} CTRL, 6, movetoworkspacesilent, 6"
        "${mainMod} CTRL, 7, movetoworkspacesilent, 7"
        "${mainMod} CTRL, 8, movetoworkspacesilent, 8"
        "${mainMod} CTRL, 9, movetoworkspacesilent, 9"
        "${mainMod} CTRL, 0, movetoworkspacesilent, 10"

        "${mainMod} CTRL SHIFT, 1, exec, ~/.config/hypr/swap-workspaces.sh $(hyprctl activeworkspace -j | jq '.id') 1"
        "${mainMod} CTRL SHIFT, 2, exec, ~/.config/hypr/swap-workspaces.sh $(hyprctl activeworkspace -j | jq '.id') 2"
        "${mainMod} CTRL SHIFT, 3, exec, ~/.config/hypr/swap-workspaces.sh $(hyprctl activeworkspace -j | jq '.id') 3"
        "${mainMod} CTRL SHIFT, 4, exec, ~/.config/hypr/swap-workspaces.sh $(hyprctl activeworkspace -j | jq '.id') 4"
        "${mainMod} CTRL SHIFT, 5, exec, ~/.config/hypr/swap-workspaces.sh $(hyprctl activeworkspace -j | jq '.id') 5"
        "${mainMod} CTRL SHIFT, 6, exec, ~/.config/hypr/swap-workspaces.sh $(hyprctl activeworkspace -j | jq '.id') 6"
        "${mainMod} CTRL SHIFT, 7, exec, ~/.config/hypr/swap-workspaces.sh $(hyprctl activeworkspace -j | jq '.id') 7"
        "${mainMod} CTRL SHIFT, 8, exec, ~/.config/hypr/swap-workspaces.sh $(hyprctl activeworkspace -j | jq '.id') 8"
        "${mainMod} CTRL SHIFT, 9, exec, ~/.config/hypr/swap-workspaces.sh $(hyprctl activeworkspace -j | jq '.id') 9"
        "${mainMod} CTRL SHIFT, 0, exec, ~/.config/hypr/swap-workspaces.sh $(hyprctl activeworkspace -j | jq '.id') 10"

        "${mainMod} SHIFT, R, exec, pkill -f 'bin/quickshel[l]'; sleep 0.3; noctalia-shell"

        "${mainMod}, R, submap, resize"

        ", Print, exec, grimblast copy output"
        "${mainMod} SHIFT, S, exec, grimblast copy area"

        "${mainMod}, C, exec, ${noctalia} launcher clipboard"
        "${mainMod}, L, exec, hyprlock"
        "${mainMod} SHIFT, C, exec, hyprpicker -a"

        "${mainMod} SHIFT, D, exec, hyprctl reload"
        "${mainMod} SHIFT, E, exec, ${noctalia} sessionMenu toggle"
      ];

      bindm = [
        "${mainMod}, mouse:272, movewindow"
        "${mainMod}, mouse:273, resizewindow"
      ];

      bindl = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"

        ", XF86MonBrightnessUp, exec, brightnessctl set +5%"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      ];

      xwayland = {
        force_zero_scaling = true;
      };

      windowrule = [
        "match:class ^(steam)$, float on, center on"

        "match:class ^(heroic)$, float on, center on"
        "match:class ^(net.lutris.Lutris)$, float on, center on"

        "match:class ^(steam_app_.*)$, immediate on, no_anim on, no_blur on, no_shadow on, fullscreen on"
        "match:class ^(gamescope)$, immediate on, no_anim on, no_blur on"
      ];
    };
  };

  home.file.".config/hypr/starfire-bg.jpg".source = ./wallpapers/starfire-bg.jpg;
  home.file.".config/hypr/swap-workspaces.sh" = {
    source = ./scripts/swap-workspaces.sh;
    executable = true;
  };
}

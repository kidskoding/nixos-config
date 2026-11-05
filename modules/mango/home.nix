{...}: {
  flake.homeModules.mango = {
    config,
    lib,
    ...
  }: let
    terminal = "ghostty";
    c = config.lib.stylix.colors;
    rgba = hex: alpha: "0x${hex}${alpha}";

    env = {
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

    autostart = [
      "noctalia"
      "nm-applet --indicator"
      "wl-paste --watch cliphist store"
      terminal
    ];
  in {
    # mango sets XDG_CURRENT_DESKTOP=mango, so the portal picks this file; FileChooser goes to kde like umbriel
    xdg.configFile."xdg-desktop-portal/mango-portals.conf".text = ''
      [preferred]
      default=gtk;
      org.freedesktop.impl.portal.FileChooser=kde;
      org.freedesktop.impl.portal.ScreenCast=wlr;
      org.freedesktop.impl.portal.Screenshot=wlr;
      org.freedesktop.impl.portal.Secret=gnome-keyring;
      org.freedesktop.impl.portal.Inhibit=none;
    '';

    programs.fish.loginShellInit = ''
      if test (tty) = /dev/tty1; and not set -q MANGO_SESSION_STARTED
        set -gx MANGO_SESSION_STARTED 1
        exec mango
      end
    '';

    xdg.configFile."mango/config.conf".text = lib.concatLines (
      lib.mapAttrsToList (k: v: "env=${k},${v}") env
      ++ map (cmd: "exec-once=${cmd}") autostart
      ++ [
        # input
        "xkb_rules_layout=us"
        "sloppyfocus=1"
        "tap_to_click=1"
        "trackpad_disable_while_typing=1"
        "trackpad_natural_scrolling=0"
        "trackpad_accel_profile=1"
        "mouse_accel_profile=1"

        # every tag scrolls, Mod+T cycles to dwindle and master-stack
        "tagrule=id:*,layout_name:scroller"
        "circle_layout=scroller,dwindle,tile"

        # a lone window fills the screen, then shrinks to its own width once a second one opens
        "scroller_ignore_proportion_single=0"
        "scroller_default_proportion_single=1.0"
        "scroller_default_proportion=0.5"
        "scroller_proportion_preset=0.33333,0.5,0.66667,1.0"
        "scroller_structs=0"
        "scroller_prefer_center=1"

        "gappih=10"
        "gappiv=10"
        "gappoh=10"
        "gappov=10"

        # look
        "borderpx=2"
        "border_radius=8"
        "focuscolor=${rgba c.base0D "ff"}"
        "bordercolor=${rgba c.base01 "ff"}"
        "rootcolor=${rgba c.base00 "ff"}"
        "focused_opacity=1.0"
        "unfocused_opacity=0.95"
        "shadows=1"
        "shadow_only_floating=0"
        "shadows_blur=20"
        "shadows_position_x=0"
        "shadows_position_y=5"
        "shadowscolor=${rgba c.base00 "ee"}"
      ]
    );
  };
}

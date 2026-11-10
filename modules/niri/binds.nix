{...}: {
  flake.homeModules.niri = {config, ...}: let
    terminal = "ghostty";
    fileManager = "nautilus";
    noctalia = c:
      [
        "noctalia"
        "msg"
      ]
      ++ c;

    locked = cmd: {
      action.spawn = cmd;
      allow-when-locked = true;
    };

    workspaceNames = [
      "1"
      "2"
      "3"
      "4"
      "5"
      "6"
      "7"
      "8"
      "9"
      "10"
    ];
  in {
    programs.niri.settings = {
      input.mod-key = config.my.modKey;

      workspaces = builtins.listToAttrs (
        map (ws: {
          name =
            if ws == "10"
            then "10"
            else "0${ws}";
          value.name = ws;
        })
        workspaceNames
      );

      binds = {
        # apps and panels
        "Mod+Return".action.spawn = terminal;
        "Mod+E".action.spawn = fileManager;
        "Mod+D".action.spawn = noctalia [
          "panel-toggle"
          "launcher"
        ];
        "Mod+Space".action.spawn = noctalia [
          "panel-toggle"
          "launcher"
        ];
        "Mod+A".action.spawn = noctalia [
          "panel-toggle"
          "control-center"
          "home"
        ];
        "Mod+C".action.spawn = noctalia [
          "panel-toggle"
          "clipboard"
        ];
        "Mod+Shift+E".action.spawn = noctalia [
          "panel-toggle"
          "session"
        ];
        "Mod+Ctrl+L".action.spawn = noctalia [
          "session"
          "lock"
        ];
        "Mod+Shift+R".action.spawn-sh = "pkill -fx '.*/bin/noctalia'; while pgrep -fx '.*/bin/noctalia' >/dev/null; do sleep 0.1; done; noctalia";
        "Mod+Shift+C".action.spawn = [
          "hyprpicker"
          "-a"
        ];

        # windows and layout
        "Mod+Q".action.close-window = [];
        "Mod+M".action.quit = [];
        "Mod+O".action.toggle-overview = [];
        "Mod+W".action.toggle-column-tabbed-display = [];
        "Mod+F".action.maximize-column = [];
        "Mod+Shift+F".action.fullscreen-window = [];
        "Mod+Shift+Space".action.toggle-window-floating = [];
        "Mod+Ctrl+Space".action.switch-focus-between-floating-and-tiling = [];
        "Mod+R".action.switch-preset-column-width = [];
        "Mod+Comma".action.consume-window-into-column = [];
        "Mod+Period".action.expel-window-from-column = [];

        # cycle focus
        "Mod+Tab".action.focus-window-down = [];
        "Mod+Shift+Tab".action.focus-window-up = [];

        # focus
        # ------- vim ----------------
        "Mod+H".action.focus-column-left = [];
        "Mod+L".action.focus-column-right = [];
        "Mod+J".action.focus-window-down = [];
        "Mod+K".action.focus-window-up = [];
        # ------- non vim ------------
        "Mod+Left".action.focus-column-left = [];
        "Mod+Right".action.focus-column-right = [];
        "Mod+Down".action.focus-window-down = [];
        "Mod+Up".action.focus-window-up = [];

        # move
        # ------- vim ----------------
        "Mod+Shift+H".action.move-column-left = [];
        "Mod+Shift+L".action.move-column-right = [];
        "Mod+Shift+J".action.move-window-down = [];
        "Mod+Shift+K".action.move-window-up = [];
        # ------- non vim ------------
        "Mod+Shift+Left".action.move-column-left = [];
        "Mod+Shift+Right".action.move-column-right = [];
        "Mod+Shift+Down".action.move-window-down = [];
        "Mod+Shift+Up".action.move-window-up = [];

        # monitors
        "Mod+BracketLeft".action.focus-monitor-left = [];
        "Mod+BracketRight".action.focus-monitor-right = [];
        "Mod+Shift+BracketLeft".action.move-column-to-monitor-left = [];
        "Mod+Shift+BracketRight".action.move-column-to-monitor-right = [];
        "Mod+Ctrl+BracketLeft".action.move-workspace-to-monitor-left = [];
        "Mod+Ctrl+BracketRight".action.move-workspace-to-monitor-right = [];

        # switch workspace
        "Mod+1".action.focus-workspace = "1";
        "Mod+2".action.focus-workspace = "2";
        "Mod+3".action.focus-workspace = "3";
        "Mod+4".action.focus-workspace = "4";
        "Mod+5".action.focus-workspace = "5";
        "Mod+6".action.focus-workspace = "6";
        "Mod+7".action.focus-workspace = "7";
        "Mod+8".action.focus-workspace = "8";
        "Mod+9".action.focus-workspace = "9";
        "Mod+0".action.focus-workspace = "10";

        # move column to workspace, follow it
        "Mod+Shift+1".action.move-column-to-workspace = "1";
        "Mod+Shift+2".action.move-column-to-workspace = "2";
        "Mod+Shift+3".action.move-column-to-workspace = "3";
        "Mod+Shift+4".action.move-column-to-workspace = "4";
        "Mod+Shift+5".action.move-column-to-workspace = "5";
        "Mod+Shift+6".action.move-column-to-workspace = "6";
        "Mod+Shift+7".action.move-column-to-workspace = "7";
        "Mod+Shift+8".action.move-column-to-workspace = "8";
        "Mod+Shift+9".action.move-column-to-workspace = "9";
        "Mod+Shift+0".action.move-column-to-workspace = "10";

        # move column to workspace, stay here
        "Mod+Ctrl+1".action.move-column-to-workspace = [{focus = false;} "1"];
        "Mod+Ctrl+2".action.move-column-to-workspace = [{focus = false;} "2"];
        "Mod+Ctrl+3".action.move-column-to-workspace = [{focus = false;} "3"];
        "Mod+Ctrl+4".action.move-column-to-workspace = [{focus = false;} "4"];
        "Mod+Ctrl+5".action.move-column-to-workspace = [{focus = false;} "5"];
        "Mod+Ctrl+6".action.move-column-to-workspace = [{focus = false;} "6"];
        "Mod+Ctrl+7".action.move-column-to-workspace = [{focus = false;} "7"];
        "Mod+Ctrl+8".action.move-column-to-workspace = [{focus = false;} "8"];
        "Mod+Ctrl+9".action.move-column-to-workspace = [{focus = false;} "9"];
        "Mod+Ctrl+0".action.move-column-to-workspace = [{focus = false;} "10"];

        # screenshots
        "Print".action.screenshot-screen = [];
        "Super+Shift+S".action.screenshot = [];

        # media and brightness, work on lock screen
        "XF86AudioRaiseVolume" = locked [
          "wpctl"
          "set-volume"
          "-l"
          "1.0"
          "@DEFAULT_AUDIO_SINK@"
          "5%+"
        ];
        "XF86AudioLowerVolume" = locked [
          "wpctl"
          "set-volume"
          "@DEFAULT_AUDIO_SINK@"
          "5%-"
        ];
        "XF86AudioMute" = locked [
          "wpctl"
          "set-mute"
          "@DEFAULT_AUDIO_SINK@"
          "toggle"
        ];
        "XF86AudioMicMute" = locked [
          "wpctl"
          "set-mute"
          "@DEFAULT_AUDIO_SOURCE@"
          "toggle"
        ];
        "XF86AudioPlay" = locked [
          "playerctl"
          "play-pause"
        ];
        "XF86AudioPause" = locked [
          "playerctl"
          "play-pause"
        ];
        "XF86AudioNext" = locked [
          "playerctl"
          "next"
        ];
        "XF86AudioPrev" = locked [
          "playerctl"
          "previous"
        ];
        "XF86MonBrightnessUp" = locked [
          "brightnessctl"
          "set"
          "+5%"
        ];
        "XF86MonBrightnessDown" = locked [
          "brightnessctl"
          "set"
          "5%-"
        ];
      };
    };
  };
}

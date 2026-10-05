{...}: let
  terminal = "ghostty";
  fileManager = "dolphin";
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
  workspaceKey = ws:
    if ws == "10"
    then "0"
    else ws;

  workspaceBinds = builtins.listToAttrs (
    builtins.concatMap (ws: [
      {
        name = "Mod+${workspaceKey ws}";
        value.action.focus-workspace = ws;
      }
      {
        name = "Mod+Shift+${workspaceKey ws}";
        value.action.move-column-to-workspace = ws;
      }
      {
        name = "Mod+Ctrl+${workspaceKey ws}";
        value.action.move-column-to-workspace = [
          {focus = false;}
          ws
        ];
      }
    ])
    workspaceNames
  );
in {
  programs.niri.settings = {
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

    binds =
      workspaceBinds
      // {
        "Mod+Return".action.spawn = terminal;
        "Mod+E".action.spawn = fileManager;
        "Mod+D".action.spawn = noctalia [
          "panel-toggle"
          "launcher"
        ];
        "Mod+C".action.spawn = noctalia [
          "panel-toggle"
          "clipboard"
        ];
        "Mod+Shift+E".action.spawn = noctalia [
          "panel-toggle"
          "session"
        ];
        "Mod+Shift+R".action.spawn-sh = "pkill -fx '.*/bin/noctalia'; while pgrep -fx '.*/bin/noctalia' >/dev/null; do sleep 0.1; done; noctalia";
        "Mod+Shift+C".action.spawn = [
          "hyprpicker"
          "-a"
        ];

        "Mod+Q".action.close-window = [];
        "Mod+M".action.quit = [];
        "Mod+O".action.toggle-overview = [];
        "Mod+W".action.toggle-column-tabbed-display = [];
        "Mod+F".action.maximize-column = [];
        "Mod+Shift+F".action.fullscreen-window = [];
        "Mod+Shift+Space".action.toggle-window-floating = [];
        "Mod+Space".action.switch-focus-between-floating-and-tiling = [];
        "Mod+R".action.switch-preset-column-width = [];
        "Mod+Comma".action.consume-window-into-column = [];
        "Mod+Period".action.expel-window-from-column = [];

        "Mod+Tab".action.focus-window-down = [];
        "Mod+Shift+Tab".action.focus-window-up = [];

        "Mod+H".action.focus-column-left = [];
        "Mod+L".action.focus-column-right = [];
        "Mod+J".action.focus-window-down = [];
        "Mod+K".action.focus-window-up = [];
        "Mod+Left".action.focus-column-left = [];
        "Mod+Right".action.focus-column-right = [];
        "Mod+Down".action.focus-window-down = [];
        "Mod+Up".action.focus-window-up = [];

        "Mod+Shift+H".action.move-column-left = [];
        "Mod+Shift+L".action.move-column-right = [];
        "Mod+Shift+J".action.move-window-down = [];
        "Mod+Shift+K".action.move-window-up = [];
        "Mod+Shift+Left".action.move-column-left = [];
        "Mod+Shift+Right".action.move-column-right = [];
        "Mod+Shift+Down".action.move-window-down = [];
        "Mod+Shift+Up".action.move-window-up = [];

        "Mod+Alt+H".action.focus-monitor-left = [];
        "Mod+Alt+L".action.focus-monitor-right = [];
        "Mod+Shift+Alt+H".action.move-column-to-monitor-left = [];
        "Mod+Shift+Alt+L".action.move-column-to-monitor-right = [];
        "Mod+Ctrl+Alt+H".action.move-workspace-to-monitor-left = [];
        "Mod+Ctrl+Alt+L".action.move-workspace-to-monitor-right = [];

        "Print".action.screenshot-screen = [];
        "Mod+Shift+S".action.screenshot = [];

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
}

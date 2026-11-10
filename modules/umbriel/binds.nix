{...}: {
  flake.homeModules.umbriel = {
    config,
    lib,
    ...
  }: let
    terminal = "ghostty";
    fileManager = "nautilus";
    noctalia = c: "spawn noctalia msg ${c}";

    locked = cmd: {
      action = "spawn ${cmd}";
      allow_when_locked = true;
    };

    screenshot = grimArgs: "spawn d=~/Pictures/Screenshots; mkdir -p $d; f=$d/$(date +%Y-%m-%dT%H:%M:%S).png; grim ${grimArgs} \"$f\" && wl-copy < \"$f\" && notify-send -a Screenshot -i \"$f\" 'Screenshot saved' \"$f\"";

    workspaceNames = map toString (lib.range 1 10);
    workspaceKey = ws:
      if ws == "10"
      then "0"
      else ws;

    workspaceBinds = builtins.listToAttrs (
      builtins.concatMap (ws: [
        {
          name = "Mod+${workspaceKey ws}";
          value = "workspace-switch --name ${ws}";
        }
        {
          name = "Mod+Shift+${workspaceKey ws}";
          value = "column-move-to-workspace --name ${ws}";
        }
        {
          name = "Mod+Ctrl+${workspaceKey ws}";
          value = "window-move-to-workspace-silent --name ${ws}";
        }
      ])
      workspaceNames
    );
  in {
    programs.umbriel.settings = {
      workspace = map (ws: {name = ws;}) workspaceNames;

      keybinds =
        workspaceBinds
        // {
          "Mod+Return" = "spawn ${terminal}";
          "Mod+E" = "spawn ${fileManager}";
          "Mod+D" = noctalia "panel-toggle launcher";
          "Mod+Space" = noctalia "panel-toggle launcher";
          "Mod+A" = noctalia "panel-toggle control-center home";
          "Mod+C" = noctalia "panel-toggle clipboard";
          "Mod+Shift+E" = noctalia "panel-toggle session";
          "Mod+Ctrl+L" = noctalia "session lock";
          "Mod+Shift+R" = "spawn pkill -fx '.*/bin/noctalia'; while pgrep -fx '.*/bin/noctalia' >/dev/null; do sleep 0.1; done; noctalia";
          "Mod+Shift+C" = "spawn hyprpicker -a";
          "Mod+P" = "spawn pkill -x wl-mirror || wl-mirror --fullscreen-output HDMI-A-1 ${config.my.display.output}";

          "Mod+Q" = "window-close";
          "Mod+M" = "session-quit";
          "Mod+O" = "overview-toggle";
          "Mod+W" = "column-toggle-tabbed";
          "Mod+T" = "workspace-set-layout toggle scrolling dwindle master";
          "Mod+F" = "window-toggle-maximize";
          "Mod+Shift+F" = "window-toggle-fullscreen";
          "Mod+Shift+Space" = "window-toggle-floating";
          "Mod+Ctrl+Space" = "window-focus-switch-floating";
          "Mod+R" = "window-cycle-primary-extent";
          "Mod+Comma" = "window-consume-from-right";
          "Mod+Period" = "window-consume-or-expel-right";

          "Mod+Tab" = "window-focus-down";
          "Mod+Shift+Tab" = "window-focus-up";

          "Mod+H" = "window-focus-left";
          "Mod+L" = "window-focus-right";
          "Mod+J" = "window-focus-down";
          "Mod+K" = "window-focus-up";
          "Mod+Left" = "window-focus-left";
          "Mod+Right" = "window-focus-right";
          "Mod+Down" = "window-focus-down";
          "Mod+Up" = "window-focus-up";

          "Mod+Shift+H" = "column-move-left";
          "Mod+Shift+L" = "column-move-right";
          "Mod+Shift+J" = "window-move-down";
          "Mod+Shift+K" = "window-move-up";
          "Mod+Shift+Left" = "column-move-left";
          "Mod+Shift+Right" = "column-move-right";
          "Mod+Shift+Down" = "window-move-down";
          "Mod+Shift+Up" = "window-move-up";

          "Mod+Alt+H" = "output-focus-left";
          "Mod+Alt+L" = "output-focus-right";
          "Mod+Shift+Alt+H" = "column-move-to-output-left";
          "Mod+Shift+Alt+L" = "column-move-to-output-right";
          "Mod+Ctrl+Alt+H" = "workspace-move-to-output-left";
          "Mod+Ctrl+Alt+L" = "workspace-move-to-output-right";

          "Print" = screenshot "";
          "Mod+Shift+S" = screenshot "-g \"$(slurp)\"";

          "XF86AudioRaiseVolume" = locked "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+";
          "XF86AudioLowerVolume" = locked "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
          "XF86AudioMute" = locked "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "XF86AudioMicMute" = locked "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          "XF86AudioPlay" = locked "playerctl play-pause";
          "XF86AudioPause" = locked "playerctl play-pause";
          "XF86AudioNext" = locked "playerctl next";
          "XF86AudioPrev" = locked "playerctl previous";
          "XF86MonBrightnessUp" = locked "brightnessctl set +5%";
          "XF86MonBrightnessDown" = locked "brightnessctl set 5%-";
        };
    };
  };
}

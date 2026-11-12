{...}: {
  flake.homeModules.umbriel = {
    config,
    lib,
    pkgs,
    ...
  }: let
    terminal = "ghostty";
    fileManager = "nautilus";
    noctalia = c: "spawn noctalia msg ${c}";

    locked = cmd: {
      action = "spawn ${cmd}";
      allow_when_locked = true;
    };

    screenshot = lib.getExe (pkgs.writeShellApplication {
      name = "screenshot";
      runtimeInputs = with pkgs; [grim slurp wl-clipboard libnotify];
      text = builtins.readFile ./screenshot.sh;
    });

    workspaceNames = ["1" "2" "3" "4" "5" "6" "7" "8" "9" "10"];
  in {
    programs.umbriel.settings = {
      general.mod_key = config.my.modKey;
      workspace = map (ws: {name = ws;}) workspaceNames;

      keybinds = {
        # apps and panels
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

        # windows and layout
        "Mod+Q" = "window-close";
        "Mod+M" = "session-quit";
        "Mod+O" = "overview-toggle";
        "Mod+T" = "workspace-set-layout toggle scrolling dwindle master";
        "Mod+F" = "window-toggle-maximize";
        "Mod+Shift+F" = "window-toggle-fullscreen";
        "Mod+Shift+Space" = "window-toggle-floating";
        "Mod+Ctrl+Space" = "window-focus-switch-floating";
        "Mod+R" = "window-cycle-primary-extent";
        "Mod+Comma" = "window-consume-from-right";
        "Mod+Period" = "window-consume-or-expel-right";

        # cycle focus
        "Alt+Tab" = noctalia "window-switcher hold";
        "Alt+Shift+Tab" = noctalia "window-switcher hold reverse";

        # focus
        # ------- vim ----------------
        "Mod+H" = "window-focus-left";
        "Mod+L" = "window-focus-right";
        "Mod+J" = "window-focus-down";
        "Mod+K" = "window-focus-up";
        # ------- non vim ------------
        "Mod+Left" = "window-focus-left";
        "Mod+Right" = "window-focus-right";
        "Mod+Down" = "window-focus-down";
        "Mod+Up" = "window-focus-up";

        # move
        # ------- vim ----------------
        "Mod+Shift+H" = "column-move-left";
        "Mod+Shift+L" = "column-move-right";
        "Mod+Shift+J" = "window-move-down";
        "Mod+Shift+K" = "window-move-up";
        # ------- non vim ------------
        "Mod+Shift+Left" = "column-move-left";
        "Mod+Shift+Right" = "column-move-right";
        "Mod+Shift+Down" = "window-move-down";
        "Mod+Shift+Up" = "window-move-up";

        # monitors
        "Mod+BracketLeft" = "output-focus-left";
        "Mod+BracketRight" = "output-focus-right";
        "Mod+Shift+BracketLeft" = "column-move-to-output-left";
        "Mod+Shift+BracketRight" = "column-move-to-output-right";
        "Mod+Ctrl+BracketLeft" = "workspace-move-to-output-left";
        "Mod+Ctrl+BracketRight" = "workspace-move-to-output-right";

        # switch workspace
        "Mod+1" = "workspace-switch --name 1";
        "Mod+2" = "workspace-switch --name 2";
        "Mod+3" = "workspace-switch --name 3";
        "Mod+4" = "workspace-switch --name 4";
        "Mod+5" = "workspace-switch --name 5";
        "Mod+6" = "workspace-switch --name 6";
        "Mod+7" = "workspace-switch --name 7";
        "Mod+8" = "workspace-switch --name 8";
        "Mod+9" = "workspace-switch --name 9";
        "Mod+0" = "workspace-switch --name 10";

        # move column to workspace, follow it
        "Mod+Shift+1" = "column-move-to-workspace --name 1";
        "Mod+Shift+2" = "column-move-to-workspace --name 2";
        "Mod+Shift+3" = "column-move-to-workspace --name 3";
        "Mod+Shift+4" = "column-move-to-workspace --name 4";
        "Mod+Shift+5" = "column-move-to-workspace --name 5";
        "Mod+Shift+6" = "column-move-to-workspace --name 6";
        "Mod+Shift+7" = "column-move-to-workspace --name 7";
        "Mod+Shift+8" = "column-move-to-workspace --name 8";
        "Mod+Shift+9" = "column-move-to-workspace --name 9";
        "Mod+Shift+0" = "column-move-to-workspace --name 10";

        # move window to workspace, stay here
        "Mod+Ctrl+1" = "window-move-to-workspace-silent --name 1";
        "Mod+Ctrl+2" = "window-move-to-workspace-silent --name 2";
        "Mod+Ctrl+3" = "window-move-to-workspace-silent --name 3";
        "Mod+Ctrl+4" = "window-move-to-workspace-silent --name 4";
        "Mod+Ctrl+5" = "window-move-to-workspace-silent --name 5";
        "Mod+Ctrl+6" = "window-move-to-workspace-silent --name 6";
        "Mod+Ctrl+7" = "window-move-to-workspace-silent --name 7";
        "Mod+Ctrl+8" = "window-move-to-workspace-silent --name 8";
        "Mod+Ctrl+9" = "window-move-to-workspace-silent --name 9";
        "Mod+Ctrl+0" = "window-move-to-workspace-silent --name 10";

        # screenshots
        "Print" = "spawn ${screenshot}";
        "Super+Shift+S" = "spawn ${screenshot} region";

        # media and brightness, work on lock screen
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

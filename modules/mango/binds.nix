{...}: {
  flake.homeModules.mango = {
    config,
    lib,
    ...
  }: let
    terminal = "ghostty";
    fileManager = "nautilus";
    noctalia = cmd: "spawn,noctalia msg ${cmd}";

    screenshot = grimArgs: "spawn_shell,d=~/Pictures/Screenshots; mkdir -p $d; f=$d/$(date +%Y-%m-%dT%H:%M:%S).png; grim ${grimArgs} \"$f\" && wl-copy < \"$f\" && notify-send -a Screenshot -i \"$f\" 'Screenshot saved' \"$f\"";

    tags = map toString (lib.range 1 9);
    tagBinds =
      lib.concatMap (t: [
        "bind=SUPER,${t},view,${t},0"
        "bind=SUPER+SHIFT,${t},tag,${t},0"
        "bind=SUPER+CTRL,${t},tagsilent,${t}"
      ])
      tags;

    locked = key: cmd: "bindl=NONE,${key},spawn,${cmd}";
  in {
    xdg.configFile."mango/config.conf".text = lib.concatLines (
      tagBinds
      ++ [
        "bind=SUPER,Return,spawn,${terminal}"
        "bind=SUPER,e,spawn,${fileManager}"
        "bind=SUPER,d,${noctalia "panel-toggle launcher"}"
        "bind=SUPER,space,${noctalia "panel-toggle launcher"}"
        "bind=SUPER,a,${noctalia "panel-toggle control-center home"}"
        "bind=SUPER,c,${noctalia "panel-toggle clipboard"}"
        "bind=SUPER+SHIFT,e,${noctalia "panel-toggle session"}"
        "bind=SUPER+CTRL,l,${noctalia "session lock"}"
        "bind=SUPER+SHIFT,r,spawn_shell,pkill -fx '.*/bin/noctalia'; while pgrep -fx '.*/bin/noctalia' >/dev/null; do sleep 0.1; done; noctalia"
        "bind=SUPER+SHIFT,c,spawn,hyprpicker -a"
        "bind=SUPER,p,spawn_shell,pkill -x wl-mirror || wl-mirror --fullscreen-output HDMI-A-1 ${config.my.display.output}"

        "bind=SUPER,q,killclient"
        "bind=SUPER,m,quit"
        "bind=SUPER,o,toggleoverview"
        "bind=SUPER,t,switch_layout"
        "bind=SUPER,f,togglemaximizescreen"
        "bind=SUPER+SHIFT,f,togglefullscreen"
        "bind=SUPER+SHIFT,space,togglefloating"
        "bind=SUPER,r,switch_proportion_preset"
        "bind=SUPER,comma,scroller_stack,left"
        "bind=SUPER,period,scroller_stack,right"

        "bind=SUPER,Tab,focusstack,next"
        "bind=SUPER+SHIFT,Tab,focusstack,prev"

        "bind=SUPER,h,focusdir,left"
        "bind=SUPER,l,focusdir,right"
        "bind=SUPER,j,focusdir,down"
        "bind=SUPER,k,focusdir,up"
        "bind=SUPER,Left,focusdir,left"
        "bind=SUPER,Right,focusdir,right"
        "bind=SUPER,Down,focusdir,down"
        "bind=SUPER,Up,focusdir,up"

        "bind=SUPER+SHIFT,h,exchange_client,left"
        "bind=SUPER+SHIFT,l,exchange_client,right"
        "bind=SUPER+SHIFT,j,exchange_client,down"
        "bind=SUPER+SHIFT,k,exchange_client,up"
        "bind=SUPER+SHIFT,Left,exchange_client,left"
        "bind=SUPER+SHIFT,Right,exchange_client,right"
        "bind=SUPER+SHIFT,Down,exchange_client,down"
        "bind=SUPER+SHIFT,Up,exchange_client,up"

        "bind=SUPER+ALT,h,focusmon,left"
        "bind=SUPER+ALT,l,focusmon,right"
        "bind=SUPER+SHIFT+ALT,h,tagmon,left"
        "bind=SUPER+SHIFT+ALT,l,tagmon,right"

        "bind=NONE,Print,${screenshot ""}"
        "bind=SUPER+SHIFT,s,${screenshot "-g \"$(slurp)\""}"

        (locked "XF86AudioRaiseVolume" "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+")
        (locked "XF86AudioLowerVolume" "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")
        (locked "XF86AudioMute" "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
        (locked "XF86AudioMicMute" "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle")
        (locked "XF86AudioPlay" "playerctl play-pause")
        (locked "XF86AudioNext" "playerctl next")
        (locked "XF86AudioPrev" "playerctl previous")
        (locked "XF86MonBrightnessUp" "brightnessctl set +5%")
        (locked "XF86MonBrightnessDown" "brightnessctl set 5%-")

        "mousebind=SUPER,btn_left,moveresize,curmove"
        "mousebind=SUPER,btn_right,moveresize,curresize"
      ]
    );
  };
}

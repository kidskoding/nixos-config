{ ... }:

{
  programs.noctalia-shell.settings.idle = {
    enabled = true;
    lockTimeout = 300;
    screenOffTimeout = 330;
    suspendTimeout = 900;
  };

  programs.niri.settings.binds."Mod+Ctrl+L".action.spawn =
    [ "noctalia-shell" "ipc" "call" "sessionMenu" "lock" ];
}

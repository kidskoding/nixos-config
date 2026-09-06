{ ... }:

{
  programs.noctalia-shell.settings.appLauncher = {
    position = "center";
    terminalCommand = "alacritty -e";
    enableClipboardHistory = true;
  };
}

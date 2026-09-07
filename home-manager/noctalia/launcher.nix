{ ... }:

{
  programs.noctalia-shell.settings.appLauncher = {
    position = "center";
    terminalCommand = "alacritty -e";
    enableClipboardHistory = true;
    sortByMostUsed = false;
    pinnedApps = [
      "Alacritty"
      "Celeste"
      "discord"
      "emacsclient"
      "Enter the Gungeon"
      "Hollow Knight"
      "lunarclient"
      "org.kde.dolphin"
      "qimgv"
      "rs.ruffle.Ruffle"
      "spotify"
      "Stardew Valley"
      "steam"
      "The Binding of Isaac Rebirth"
      "thunderbird"
    ];
  };
}

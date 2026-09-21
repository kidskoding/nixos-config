{ ... }:

{
  programs.noctalia-shell.settings.appLauncher = {
    position = "center";
    terminalCommand = "alacritty -e";
    enableClipboardHistory = true;
    sortByMostUsed = false;

    pinnedApps = [
      "NixOS Manual"
      "Alacritty"
      "Celeste"
      "Claude"
      "discord"
      "Enter the Gungeon"
      "Hollow Knight"
      "lunarclient"
      "Neovim wrapper"
      "Orca"
      "org.kde.dolphin"
      "qimgv"
      "rs.ruffle.Ruffle"
      "spotify"
      "Stardew Valley"
      "steam"
      "The Binding of Isaac Rebirth"
      "thunderbird"
      "zen-beta"
    ];
  };
}

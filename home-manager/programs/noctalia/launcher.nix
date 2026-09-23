{...}: {
  programs.noctalia-shell.settings.appLauncher = {
    position = "center";
    terminalCommand = "ghostty -e";
    enableClipboardHistory = true;
    sortByMostUsed = false;

    pinnedApps = [
      "NixOS Manual"
      "Ghostty"
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

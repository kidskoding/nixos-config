{...}: {
  programs.niri.settings.environment.TERMINAL = "ghostty";

  programs.noctalia.settings.shell.launcher = {
    categories = false;
    sort_by_usage = false;

    pinned = [
      "nixos-manual"
      "com.mitchellh.ghostty"
      "Celeste"
      "claude"
      "discord"
      "Enter the Gungeon"
      "Hollow Knight"
      "lunarclient"
      "neovide"
      "orca-ide"
      "org.kde.dolphin"
      "qimgv"
      "rs.ruffle.Ruffle"
      "spotify"
      "Stardew Valley"
      "steam"
      "The Binding of Isaac Rebirth"
      "zen-beta"
    ];
  };
}

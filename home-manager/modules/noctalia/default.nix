{ config, inputs, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default

    ./bar.nix
    ./colors.nix
    ./launcher.nix
    ./lock.nix
    ./notifications.nix
  ];

  programs.noctalia-shell = {
    enable = true;

    settings = {
      settingsVersion = 59;

      general.dimmerOpacity = 0.0;
      general.avatarImage = "${./avatar.jpg}";
      ui.fontDefault = config.theme.fontFamily;
      ui.fontFixed = config.theme.fontFamily;

      location.useFahrenheit = true;
      location.autoLocate = true;
      location.use12hourFormat = true;

      audio = {
        volumeStep = 5;
        preferredPlayer = "spotify";
      };

      brightness.brightnessStep = 5;

      systemMonitor = {
        batteryWarningThreshold = 30;
        batteryCriticalThreshold = 15;
      };

      wallpaper.enabled = false;

      dock.enabled = false;
    };
  };
}

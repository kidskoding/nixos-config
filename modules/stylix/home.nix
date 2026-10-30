{...}: {
  flake.homeModules.kidskoding = {
    stylix.targets = {
      bat.enable = false;
      cava.rainbow.enable = true;
      gnome.enable = false;
      helix.enable = false;
      kde.enable = false;
      qt.enable = false;
      rofi.enable = false;
    };
  };
}

{...}: {
  flake.homeModules.base = {
    stylix.targets = {
      cava.rainbow.enable = true;
      gnome.enable = false;
      kde.enable = false;
      qt.enable = false;
      rofi.enable = false;
    };
  };
}

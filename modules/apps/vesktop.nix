{...}: {
  flake.homeModules.desktop = {...}: {
    programs.vesktop.enable = true;

    stylix.targets.vesktop.enable = false;
  };
}

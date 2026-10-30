{...}: {
  flake.nixosModules.gaming = {
    programs.steam.enable = true;
    programs.gamescope.enable = true;
    programs.gamemode.enable = true;
  };
}

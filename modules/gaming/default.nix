{self, ...}: {
  flake.nixosModules.gaming = {
    home-manager.sharedModules = [self.homeModules.gaming];

    programs.steam.enable = true;
    programs.gamescope.enable = true;
    programs.gamemode.enable = true;
  };
}

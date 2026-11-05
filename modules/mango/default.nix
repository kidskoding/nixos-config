{self, ...}: {
  flake.nixosModules.mango = {
    programs.mango.enable = true;
    home-manager.sharedModules = [self.homeModules.mango];
  };
}

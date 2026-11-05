{self, ...}: {
  # mango is the primary compositor; umbriel stays installed as a fallback session
  flake.nixosModules.mango = {
    programs.mango.enable = true;
    home-manager.sharedModules = [self.homeModules.mango];
  };
}

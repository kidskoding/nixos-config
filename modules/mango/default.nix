{self, ...}: {
  flake.nixosModules.mango = {
    home-manager.sharedModules = [self.homeModules.mango];

    programs.mango.enable = true;
  };

  flake.homeModules.mango = {config, ...}: {
    xdg.configFile."mango/config.conf".source =
      config.lib.file.mkOutOfStoreSymlink "/home/kidskoding/nixos/modules/mango/config.conf";
  };
}

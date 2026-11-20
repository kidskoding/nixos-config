# the kidskoding home every host gets; hosts pick the rest in modules/hosts/
{self, ...}: {
  flake.nixosModules.kidskoding = {...}: {
    home-manager.users.kidskoding = {
      imports = [
        self.homeModules.base
      ];
    };
  };
}

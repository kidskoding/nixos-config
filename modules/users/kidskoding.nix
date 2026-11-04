# the kidskoding home every host gets; hosts pick the rest in modules/hosts/
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.kidskoding = {...}: {
    home-manager.users.kidskoding = {
      imports = [
        self.homeModules.base
        inputs.sops-nix.homeManagerModules.sops
      ];

      programs.fish.shellAliases.rebuild = "/home/kidskoding/nixos/scripts/rebuild.sh";
    };
  };
}

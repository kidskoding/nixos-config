{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.kidskoding = {...}: {
    home-manager.users.kidskoding = {
      imports = [
        self.homeModules.kidskoding
        self.homeModules.desktop
        inputs.sops-nix.homeManagerModules.sops
      ];

      programs.fish.shellAliases.rebuild = "/home/kidskoding/nixos/scripts/rebuild.sh";
    };
  };
}

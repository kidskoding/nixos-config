# home-manager groups for the nixos laptops; non-nixos machines are in modules/homes/
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.kidskoding = {...}: {
    home-manager.users.kidskoding = {
      imports = [
        self.homeModules.base
        self.homeModules.dev
        self.homeModules.agents
        self.homeModules.desktop
        inputs.sops-nix.homeManagerModules.sops
      ];

      programs.fish.shellAliases.rebuild = "/home/kidskoding/nixos/scripts/rebuild.sh";
    };
  };
}

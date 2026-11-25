{
  inputs,
  self,
  ...
}: {
  flake.nixosModules.base = ../configuration.nix;
  flake.homeModules.base = ../home.nix;

  flake.nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      inherit inputs;
    };
    modules = with self.nixosModules; [
      base
      shell
      theme

      niri
      noctalia
      desktop

      dev
      agents
    ];
  };
}

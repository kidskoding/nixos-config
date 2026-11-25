{
  inputs,
  self,
  ...
}: {
  flake.nixosModules.base = ../configuration.nix;
  flake.homeModules.base = ../home.nix;

  flake.nixosConfigurations."thinkpad-e16g5" = inputs.nixpkgs.lib.nixosSystem {
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

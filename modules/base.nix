{...}: {
  flake.nixosModules.base = ../configuration.nix;
  flake.homeModules.base = ../home.nix;
}

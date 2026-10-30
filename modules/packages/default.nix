{inputs, ...}: {
  flake.homeModules.base = {pkgs, ...}: let
    system = pkgs.stdenv.hostPlatform.system;
  in {
    my.caches = [
      # matui cache
      {
        url = "https://pkulak.cachix.org";
        key = "pkulak.cachix.org-1:S25jAptWCkAmwrk41b47lheB9onW9mzxVqM9o6HRg1E=";
      }
    ];

    home.packages = [
      inputs.aoc-cli.packages.${system}.default

      inputs.matui.packages.${system}.default
      inputs.toofan.packages.${system}.default
    ];
  };
}

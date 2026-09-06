{
  description = "bun project built from bun.lock";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    bun2nix = {
      url = "github:nix-community/bun2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, bun2nix, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ bun2nix.overlays.default ];
      };
    in {
      packages.${system}.default = pkgs.callPackage ./default.nix { };

      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          bun
          bun2nix
        ];

        shellHook = ''
          bun install --frozen-lockfile
        '';
      };
    };
}

{
  description = "rust project built from Cargo.lock";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    crane.url = "github:ipetkov/crane";
  };

  outputs = {
    nixpkgs,
    crane,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    craneLib = crane.mkLib pkgs;
  in {
    packages.${system}.default = craneLib.buildPackage {
      src = craneLib.cleanCargoSource ./.;
      strictDeps = true;
    };

    devShells.${system}.default = craneLib.devShell {
      packages = with pkgs; [
        bacon
        cargo-chef
        cargo-generate
        evcxr
        trunk
        wasm-pack

        rust-analyzer
      ];

      shellHook = ''
        [ -f Cargo.lock ] || cargo generate-lockfile
      '';
    };
  };
}

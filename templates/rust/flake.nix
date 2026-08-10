{
  description = "anirudh's rust dev environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, fenix, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      toolchain = fenix.packages.${system}.stable.withComponents [
        "cargo"
        "clippy"
        "rust-analyzer"
        "rust-src"
        "rustc"
        "rustfmt"
      ];
    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = [ toolchain ] ++ (with pkgs; [
          # "accessories" for rust
          bacon
          cargo-chef
          evcxr
          loco
          trunk
          wasm-pack
        ]);

        RUST_BACKTRACE = "1";
      };
    };
}

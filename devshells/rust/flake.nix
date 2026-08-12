{
  description = "rust dev shell with direnv";

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

        shellHook = ''
          if [ -d .git ]; then
            grep -qxF '.envrc' .git/info/exclude 2>/dev/null \
              || printf '.envrc\n.direnv/\n' >> .git/info/exclude
            [ -f .envrc ] \
              || printf 'use flake "$HOME/nixos?dir=devshells/rust"\n' > .envrc
          fi
        '';
      };
    };
}

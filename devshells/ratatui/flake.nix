{
  description = "ratatui dev shell (stable toolchain, nightly rustfmt for cargo xtask format)";

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
      fx = fenix.packages.${system};
      toolchain = fx.combine [
        (fx.stable.withComponents [
          "cargo"
          "clippy"
          "rust-analyzer"
          "rust-src"
          "rustc"
        ])
        fx.complete.rustfmt
      ];
    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = [ toolchain ] ++ (with pkgs; [
          bacon
          evcxr
        ]);

        RUST_BACKTRACE = "1";

        shellHook = ''
          if [ -d .git ]; then
            grep -qxF '.envrc' .git/info/exclude 2>/dev/null \
              || printf '.envrc\n.direnv/\n' >> .git/info/exclude
            [ -f .envrc ] \
              || printf 'use flake "$HOME/nixos?dir=devshells/ratatui"\n' > .envrc
          fi
        '';
      };
    };
}

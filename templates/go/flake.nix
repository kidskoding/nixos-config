{
  description = "anirudh's go dev environment";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { nixpkgs, ... }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in {
      devShells.x86_64-linux.default = pkgs.mkShell {
        packages = with pkgs; [
          # go
          go
          golangci-lint
          gopls
          gotools

          # "accessories" for go
          delve
          gomodifytags
          gore
          gotests
        ];
      };
    };
}

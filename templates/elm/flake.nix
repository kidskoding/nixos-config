{
  description = "anirudh's elm dev environment";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { nixpkgs, ... }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in {
      devShells.x86_64-linux.default = pkgs.mkShell {
        packages = with pkgs.elmPackages; [
          elm
          elm-format
          elm-json
          elm-language-server
          elm-test
          elm-review
        ];
      };
    };
}

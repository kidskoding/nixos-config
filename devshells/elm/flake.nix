{
  description = "elm dev shell";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.${system}.default = pkgs.mkShell {
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

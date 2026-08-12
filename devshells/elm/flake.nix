{
  description = "elm dev shell with direnv";

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

        shellHook = ''
          if [ -d .git ]; then
            grep -qxF '.envrc' .git/info/exclude 2>/dev/null \
              || printf '.envrc\n.direnv/\n' >> .git/info/exclude
            [ -f .envrc ] \
              || printf 'use flake "$HOME/nixos?dir=devshells/elm"\n' > .envrc
          fi
        '';
      };
    };
}

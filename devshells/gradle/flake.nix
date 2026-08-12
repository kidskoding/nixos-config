{
  description = "gradle dev shell with direnv";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      jdk = pkgs.jdk21;
    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = [
          jdk
          (pkgs.gradle.override { java = jdk; })
        ];

        env = {
          JAVA_HOME = jdk;
          GRADLE_USER_HOME = ".gradle";
        };

        shellHook = ''
          if [ -d .git ]; then
            grep -qxF '.envrc' .git/info/exclude 2>/dev/null \
              || printf '.envrc\n.direnv/\n' >> .git/info/exclude
            [ -f .envrc ] \
              || printf 'use flake "$HOME/nixos?dir=devshells/gradle"\n' > .envrc
          fi
        '';
      };
    };
}

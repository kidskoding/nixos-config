{
  description = "anirudh's gradle dev environment";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { nixpkgs, ... }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      jdk = pkgs.jdk21;
    in {
      devShells.x86_64-linux.default = pkgs.mkShell {
        packages = [
          jdk
          (pkgs.gradle.override { java = jdk; })
        ];

        env = {
          JAVA_HOME = jdk;

          # keep the gradle daemon's caches inside the project instead of
          # ~/.gradle, so state is scoped per-project
          GRADLE_USER_HOME = ".gradle";
        };
      };
    };
}

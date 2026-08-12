{
  description = "gradle dev shell";

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
      };
    };
}

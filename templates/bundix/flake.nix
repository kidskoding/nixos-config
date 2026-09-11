{
  description = "ruby project built from Gemfile.lock";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      ruby = pkgs.ruby_3_4;

      # bundix turns Gemfile.lock into gemset.nix; bundlerEnv builds every gem
      # from it in the nix sandbox, so `bundle install` never runs here
      gems = pkgs.bundlerEnv {
        name = "gems";
        inherit ruby;
        gemdir = ./.;
      };
      hasGemset = builtins.pathExists ./gemset.nix;
    in {
      packages.${system}.default = gems;

      devShells.${system}.default = pkgs.mkShell {
        # gems first so its bundle wrapper shadows ruby's plain bundle
        packages = pkgs.lib.optional hasGemset gems ++ [ ruby pkgs.bundix ];

        shellHook = ''
          if [ -f Gemfile ] && [ ! -f gemset.nix ]; then
            echo "no gemset.nix, generating from Gemfile..."
            bundle lock && bundix && echo "gemset.nix written, reload the shell"
          fi
        '';
      };
    };
}

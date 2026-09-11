{
  description = "ruby project built from Gemfile.lock";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    devenv.url = "github:cachix/devenv";
  };

  outputs = { nixpkgs, devenv, ... }@inputs:
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

      devShells.${system}.default = devenv.lib.mkShell {
        inherit inputs pkgs;
        modules = [{
          # gems first so its bundle wrapper shadows ruby's plain bundle
          packages = pkgs.lib.optional hasGemset gems ++ [ ruby pkgs.bundix ];

          services.postgres.enable = true;

          enterShell = ''
            # no Gemfile yet: bootstrap a rails app. `gem install` needs a
            # writable home since the nix store is read-only.
            if [ ! -f Gemfile ]; then
              export GEM_HOME="$PWD/.nix-gems"
              export PATH="$GEM_HOME/bin:$PATH"
              echo "no Gemfile found, installing rails ''${RAILS_VERSION:-(latest)}..."
              gem install --no-document rails ''${RAILS_VERSION:+-v "$RAILS_VERSION"}
              rails new . --skip-bundle --database=postgresql
              # bundix does not know the `windows` platform alias and crashes on
              # deps restricted to it; tzinfo-data is windows-only anyway
              sed -i -e '/tzinfo-data/d' -e 's/, platforms: %i\[[^]]*\]//' Gemfile
            fi

            # bundix cannot fetch platform-specific gems (nokogiri-x86_64-linux),
            # so lock against the plain ruby platform and build natives from source
            if [ ! -f gemset.nix ]; then
              echo "no gemset.nix, generating from Gemfile..."
              bundle config set --local force_ruby_platform true
              bundle lock && bundix && echo "gemset.nix written, reload the shell"
            fi
          '';
        }];
      };
    };
}

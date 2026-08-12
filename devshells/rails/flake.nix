{
  description = "ruby on rails dev shell";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          ruby_3_4

          # native-gem build deps
          libyaml
          openssl
          zlib

          # rails
          libxml2 libxslt   # nokogiri
          sqlite            # sqlite3 gem (the default rails dev db)
        ];

        env = {
          # keep bundler-installed gems local to the project, not the
          # shared user gem home, so `bundle install` stays reproducible
          # and scoped per-project
          BUNDLE_PATH = "vendor/bundle";
        };

        shellHook = ''
          # the nix store is read-only, so `gem install` needs a writable home.
          # per-project rather than shared: two projects pinned to different
          # rails versions should not fight over one gem home.
          export GEM_HOME="$PWD/.nix-gems"
          export PATH="$GEM_HOME/bin:$PATH"

          if [ ! -f Gemfile ]; then
            # pin with RAILS_VERSION=8.1.3.1 nix develop, else take the latest.
            echo "no Gemfile found, installing rails ''${RAILS_VERSION:-(latest)}..."
            gem install --no-document rails ''${RAILS_VERSION:+-v "$RAILS_VERSION"}

            rails new . --skip-bundle --database=sqlite3
            bundle install

            grep -qxF '/.nix-gems' .gitignore 2>/dev/null \
              || echo '/.nix-gems' >> .gitignore
          fi
        '';
      };
    };
}

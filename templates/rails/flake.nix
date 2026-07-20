{
  description = "ruby on rails dev environment";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { nixpkgs, ... }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in {
      devShells.x86_64-linux.default = pkgs.mkShell {
        packages = with pkgs; [
          # ruby + rails + bundler + sqlite3 gem, all from nixpkgs
          # (no `gem install` needed to bootstrap `rails new`)
          (ruby.withPackages (ps: [ ps.rails ps.sqlite3 ]))

          # native-gem build deps
          libyaml
          openssl
          zlib

          # rails
          sqlite            # sqlite3 gem (the default rails dev db)
          libxml2 libxslt   # nokogiri

          # swap in sqlite for postgres if using postgres instead:
          # postgresql      # pg gem
        ];

        env = {
          # keep bundler-installed gems local to the project, not the
          # shared user gem home, so `bundle install` stays reproducible
          # and scoped per-project
          BUNDLE_PATH = "vendor/bundle";
        };

        shellHook = ''
          if [ ! -f Gemfile ]; then
            echo "no Gemfile found, scaffolding a new rails app..."
            rails new . --skip-bundle --database=sqlite3
            bundle install
          fi
        '';
      };
    };
}

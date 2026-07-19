{
  description = "ruby on rails dev environment";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { nixpkgs, ... }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in {
      devShells.x86_64-linux.default = pkgs.mkShell {
        packages = with pkgs; [
          ruby

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
      };
    };
}

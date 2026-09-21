{
  description = "anirudh's nixvim config!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixvim.url = "github:nix-community/nixvim";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    { nixvim, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      perSystem =
        { system, ... }:
        let
          configuration = nixvim.lib.evalNixvim {
            inherit system;

            # import nixvim modules!
            modules = [ ./config ];

            extraSpecialArgs = {
              # inherit (inputs) foo;
            };
          };
        in
        {
          # run `nix flake check .` to verify that your config is not broken!
          checks.default = configuration.config.build.test;

          # test nvim config with `nix run .` before rebuilding system!
          packages.default = configuration.config.build.package;
        };
    };
}

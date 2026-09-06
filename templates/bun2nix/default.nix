{ bun2nix, ... }:

let
  packageJson = builtins.fromJSON (builtins.readFile ./package.json);
in
bun2nix.mkDerivation {
  packageJson = ./package.json;
  version = packageJson.version or "0.1.0";

  src = ./.;

  bunDeps = bun2nix.fetchBunDeps {
    bunNix = ./bun.nix;
  };
}

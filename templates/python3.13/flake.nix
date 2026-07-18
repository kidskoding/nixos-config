{
  description = "python dev shell";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { nixpkgs, ... }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in {
      devShells.x86_64-linux.default = pkgs.mkShell {
        packages = with pkgs; [
          python313
        ];

        env = {
          # always use the nix-provided python, never download / install one
          UV_PYTHON_DOWNLOADS = "never";
        };
      };
    };
}

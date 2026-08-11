{
  description = "python dev shell (nix-provided interpreter, whilst uv owns deps)";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          python313
          uv
          ruff
        ];

        env = {
          UV_PYTHON_DOWNLOADS = "never";
          UV_PYTHON_PREFERENCE = "only-system";
          UV_SYSTEM_PYTHON = 1;
        };

        shellHook = ''
          if [ -d .git ]; then
            grep -qxF '.envrc' .git/info/exclude 2>/dev/null \
              || printf '.envrc\n.direnv/\n' >> .git/info/exclude
            [ -f .envrc ] \
              || printf 'use flake "$HOME/nixos?dir=devshells/python"\n' > .envrc
          fi
        '';
      };
    };
}

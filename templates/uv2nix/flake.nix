{
  description = "python project built from uv.lock";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    pyproject-nix = {
      url = "github:pyproject-nix/pyproject.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    uv2nix = {
      url = "github:pyproject-nix/uv2nix";
      inputs.pyproject-nix.follows = "pyproject-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pyproject-build-systems = {
      url = "github:pyproject-nix/build-system-pkgs";
      inputs.pyproject-nix.follows = "pyproject-nix";
      inputs.uv2nix.follows = "uv2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, pyproject-nix, uv2nix, pyproject-build-systems, ... }:
    let
      inherit (nixpkgs) lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      workspace = uv2nix.lib.workspace.loadWorkspace { workspaceRoot = ./.; };

      overlay = workspace.mkPyprojectOverlay { sourcePreference = "wheel"; };
      editableOverlay = workspace.mkEditablePyprojectOverlay { root = "$REPO_ROOT"; };

      pythonSet = (pkgs.callPackage pyproject-nix.build.packages {
        python = pkgs.python313;
      }).overrideScope (lib.composeManyExtensions [
        pyproject-build-systems.overlays.wheel
        overlay
      ]);

      pyproject = lib.importTOML ./pyproject.toml;
    in {
      packages.${system}.default =
        pythonSet.mkVirtualEnv pyproject.project.name workspace.deps.default;

      devShells.${system}.default =
        let
          virtualenv =
            (pythonSet.overrideScope editableOverlay).mkVirtualEnv
              "app-dev-env" workspace.deps.all;
        in pkgs.mkShell {
          packages = [
            virtualenv
            pkgs.ruff
            pkgs.uv
            pkgs.ty
          ];

          env = {
            UV_NO_SYNC = "1";
            UV_PYTHON = pythonSet.python.interpreter;
            UV_PYTHON_DOWNLOADS = "never";
          };

          shellHook = ''
            unset PYTHONPATH
            export REPO_ROOT=$(git rev-parse --show-toplevel)
          '';
        };
    };
}

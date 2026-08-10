{
  description = "anirudh's nixos flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # advent of code cli (my fork)
    aoc-cli = {
      url = "github:kidskoding/aoc-cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # coding agents
    antigravity-cli = {
      url = "github:Hy4ri/antigravity-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    claude-code-cli = {
      url = "github:sadjow/claude-code-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    codex-cli = {
      url = "github:sadjow/codex-cli-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # emacs (bleeding-edge builds, e.g. emacs-unstable)
    emacs-overlay.url = "github:nix-community/emacs-overlay";

    # rust tooling
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # matrix tui client
    matui = {
      url = "github:pkulak/matui";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # noctalia
    noctalia = {
      url = "github:noctalia-dev/noctalia/legacy-v4";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # secrets (sops)
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # productivity
    timer = {
      url = "github:sectore/timr-tui";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    toofan = {
      url = "github:vyrx-dev/toofan";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, ... }:
  let
    system = "x86_64-linux";
  in {
    templates = {
      go = {
        path = ./templates/go;
        description = "go dev shell with direnv";
      };

      gradle = {
        path = ./templates/gradle;
        description = "gradle dev shell with direnv";
      };

      python = {
        path = ./templates/python3.13;
        description = "python dev shell with direnv";
      };

      rails = {
        path = ./templates/rails;
        description = "ruby on rails dev shell with direnv";
      };

      rust = {
        path = ./templates/rust;
        description = "rust dev shell with direnv";
      };
    };

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        inputs.home-manager.nixosModules.home-manager {
          environment.systemPackages = [
            inputs.aoc-cli.packages.${system}.default

            inputs.antigravity-cli.packages.${system}.default
            inputs.claude-code-cli.packages.${system}.default
            inputs.codex-cli.packages.${system}.default

            # rust stable toolchain
            (inputs.fenix.packages.${system}.stable.withComponents [
              "cargo"
              "clippy"
              "rust-analyzer"
              "rust-src"
              "rustc"
              "rustfmt"
            ])

            inputs.matui.packages.${system}.default
            inputs.timer.packages.${system}.default
            inputs.toofan.packages.${system}.default
          ];

          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit inputs; };
            users.anirudh = import ./home-manager/home.nix;
          };
        }
      ];
    };
  };
}

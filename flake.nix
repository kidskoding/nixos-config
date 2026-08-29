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
    claude-desktop.url = "github:k3d3/claude-desktop-linux-flake";
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

    # niri
    niri.url = "github:sodiboo/niri-flake";

    # noctalia
    noctalia = {
      url = "github:noctalia-dev/noctalia/legacy-v4";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
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

    # zen (browser)
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
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
      python = {
        path = ./templates/python;
        description = "python template (the nix way without uv)";
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
        ./home-manager/modules/noctalia/greeter.nix
        inputs.niri.nixosModules.niri
        inputs.noctalia-greeter.nixosModules.default

        inputs.home-manager.nixosModules.home-manager {
          environment.systemPackages = [
            inputs.aoc-cli.packages.${system}.default

            inputs.antigravity-cli.packages.${system}.default
            inputs.claude-code-cli.packages.${system}.default
            inputs.claude-desktop.packages.${system}.claude-desktop-with-fhs
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
            inputs.zen-browser.packages.${system}.default
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

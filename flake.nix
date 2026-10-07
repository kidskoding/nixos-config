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
    llm-agents.url = "github:numtide/llm-agents.nix";

    # coding agent skills, plugins, settings
    anikonistack = {
      url = "github:kidskoding/anikonistack";
      inputs.claude-code-nix.follows = "claude-code-cli";
    };

    # rust tooling
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # vite-plus
    nix-vite-plus = {
      url = "github:ryoppippi/nix-vite-plus";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # niri
    niri.url = "github:sodiboo/niri-flake";

    # noctalia
    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # stylix: nix in style 💎!!
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # disko: declarative disk layout!
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # secrets (sops)
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # productivity
    matui.url = "github:pkulak/matui"; # matrix tui client
    toofan.url = "github:vyrx-dev/toofan";

    # browsers
    cromite = {
      url = "github:Impqxr/cromite-nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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

  outputs = inputs @ {nixpkgs, ...}: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    devShells.${system} = import ./devshells {
      inherit pkgs;
      fenix = inputs.fenix.packages.${system};
    };

    templates = {
      uv2nix = {
        path = ./templates/uv2nix;
        description = "python project built from uv.lock";
      };

      bun2nix = {
        path = ./templates/bun2nix;
        description = "bun project built from bun.lock";
      };

      crane = {
        path = ./templates/crane;
        description = "rust project built from Cargo.lock";
      };

      bundix = {
        path = ./templates/bundix;
        description = "ruby project built from Gemfile.lock";
      };
    };

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs;};
      modules = [./configuration.nix];
    };
  };
}

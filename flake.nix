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

    # emacs (bleeding-edge builds, e.g. emacs-unstable)
    emacs-overlay.url = "github:nix-community/emacs-overlay";

    # rust tooling
    fenix = {
      url = "github:nix-community/fenix";
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
    matui = {
      # matrix tui client
      url = "github:pkulak/matui";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    toofan = {
      url = "github:vyrx-dev/toofan";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

  outputs =
    inputs@{ nixpkgs, ... }:
    let
      system = "x86_64-linux";
    in
    {
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
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          ./home-manager/programs/noctalia/greeter.nix
          inputs.niri.nixosModules.niri
          inputs.noctalia-greeter.nixosModules.default

          inputs.home-manager.nixosModules.home-manager
          {
            environment.systemPackages = [
              inputs.aoc-cli.packages.${system}.default

              inputs.antigravity-cli.packages.${system}.default
              inputs.claude-code-cli.packages.${system}.default
              inputs.claude-desktop.packages.${system}.claude-desktop-with-fhs
              inputs.codex-cli.packages.${system}.default

              # coding agents (used within llm-agents package!)
              # inputs.llm-agents.packages.${system}.coco             # snowflake, cortex code cli!
              # inputs.llm-agents.packages.${system}.copilot-cli      # github copilot cli
              # inputs.llm-agents.packages.${system}.cline            # autonomous coding agent cli!
              # inputs.llm-agents.packages.${system}.crush            # charmbracelet's glamourous ai coding agent!
              # inputs.llm-agents.packages.${system}.cursor-agent     # cursor/spacexai's coding agent cli!
              # inputs.llm-agents.packages.${system}.grok             # spacexai's/xai's coding agent cli!
              # inputs.llm-agents.packages.${system}.junie            # jetbrains's ai coding agent cli!
              # inputs.llm-agents.packages.${system}.mistral-vibe     # mistral ai's minimal coding agent cli!
              inputs.llm-agents.packages.${system}.orca # a wonderful ade for working with many coding agents!
              # inputs.llm-agents.packages.${system}.pi               # a wonderful agent harness!
              # inputs.llm-agents.packages.${system}.qwen-code          # agent cli / workflow tool for the family of Qwen3 models!

              # ai assistants
              inputs.llm-agents.packages.${system}.hermes-agent # hermes-agent cli!
              inputs.llm-agents.packages.${system}.hermes-desktop # hermes-agent desktop!

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
              inputs.toofan.packages.${system}.default

              inputs.cromite.packages.${system}.default
              inputs.zen-browser.packages.${system}.default
            ];

            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "bak";
              extraSpecialArgs = { inherit inputs; };
              users.anirudh = import ./home-manager/home.nix;
            };
          }
        ];
      };
    };
}

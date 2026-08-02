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

  outputs = inputs@{ self, nixpkgs, home-manager, aoc-cli, claude-code-cli, codex-cli, fenix, matui, toofan, timer, ... }: {
    templates.go = {
      path = ./templates/go;
      description = "go dev shell with direnv";
    };

    templates.gradle = {
      path = ./templates/gradle;
      description = "gradle dev shell with direnv";
    };

    templates.python = {
      path = ./templates/python3.13;
      description = "python dev shell with direnv";
    };

    templates.rails = {
      path = ./templates/rails;
      description = "ruby on rails dev shell with direnv";
    };

    templates.rust = {
      path = ./templates/rust;
      description = "rust dev shell with direnv";
    };

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager {
          environment.systemPackages = [
            aoc-cli.packages.x86_64-linux.default
            claude-code-cli.packages.x86_64-linux.default
            codex-cli.packages.x86_64-linux.default

            # rust stable toolchain
            (fenix.packages.x86_64-linux.stable.withComponents [
              "cargo"
              "clippy"
              "rust-analyzer"
              "rust-src"
              "rustc"
              "rustfmt"
            ])

            matui.packages.x86_64-linux.default
            timer.packages.x86_64-linux.default
            toofan.packages.x86_64-linux.default
          ];

          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.anirudh = import ./home-manager/home.nix;
        }
      ];
    };
  };
}

{
  description = "anirudh's nixos flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # home manager!!
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # dendriticness!!
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

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
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # neovim nightly (0.13.0-dev)
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    # rust nightly (fenix latest)
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # vite-plus
    nix-vite-plus = {
      url = "github:ryoppippi/nix-vite-plus";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # umbriel
    umbriel = {
      url = "github:noctalia-dev/umbriel";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # noctalia
    noctalia = {
      url = "github:kidskoding/noctalia/nixos";
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

    # artcraft: rust clones of creative/office apps
    artcraft-nix.url = "github:applicative-systems/artcraft-nix";
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;}
    (inputs.import-tree.matchNot ".*/nvim/config/.*" ./modules);
}

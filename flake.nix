{
  description = "anirudh's nixos flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # home manager !!
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # dendriticness !!
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    # advent of code cli ⭐ !!
    aoc-cli = {
      url = "github:kidskoding/aoc-cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ai / coding agents ✴️ !!
    llm-agents.url = "github:numtide/llm-agents.nix";
    anikonistack = {
      # coding agent skills, plugins, settings
      url = "github:kidskoding/anikonistack";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # neovim nightly
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    # rust nightly 🦀 !!
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # vite-plus
    nix-vite-plus = {
      url = "github:ryoppippi/nix-vite-plus";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # niri: an amazing 1D scrolling compositor for wayland !!
    niri.url = "github:sodiboo/niri-flake";

    # noctalia: the noctalia family 🌙 !!
    noctalia = {
      url = "github:kidskoding/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # stylix: nix in style 💎 !!
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # catppuccin: a soothing pastel theme 🐈 !!
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # disko: declarative disk layout !!
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # sops: secrets 🤫 !!
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
    #
    # zen: a calm gecko/firefox based web browser 🪷 !!
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    cromite = {
      # chromium based browser (for when i need it)
      url = "github:Impqxr/cromite-nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # artcraft: rust clones of the original creative/office apps from adobe !!
    artcraft-nix.url = "github:applicative-systems/artcraft-nix";
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;}
    (inputs.import-tree.matchNot ".*/nvim/config/.*" ./modules);
}

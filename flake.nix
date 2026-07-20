{
  description = "anirudh's nixos flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    # coding agents
    claude-code-cli.url = "github:sadjow/claude-code-nix";
    codex-cli.url = "github:sadjow/codex-cli-nix";

    # matrix tui client
    matui.url = "github:pkulak/matui";

    # rust tooling
    fenix = {
	url = "github:nix-community/fenix";
	inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      	url = "github:nix-community/home-manager";
      	inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, claude-code-cli, codex-cli, matui, fenix, ... }: {
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
      modules = [
	 ./configuration.nix
	 home-manager.nixosModules.home-manager {
	     environment.systemPackages = [
	       claude-code-cli.packages.x86_64-linux.default
	       codex-cli.packages.x86_64-linux.default
	       matui.packages.x86_64-linux.matui

	       # rust stable toolchain
	       (fenix.packages.x86_64-linux.stable.withComponents [
	         "cargo"
	         "clippy"
	         "rustc"
	         "rustfmt"
	         "rust-src"
	       ])
	     ];
	
	     home-manager.useGlobalPkgs = true;
	     home-manager.useUserPackages = true;
	     home-manager.users.anirudh = import ./home-manager/home.nix;
         }
      ];
    };
  };
}

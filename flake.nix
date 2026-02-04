{
    description = "Anirudh's NixOS Flake";

    inputs = {
	nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

	home-manager = {
	    url = "github:nix-community/home-manager/release-25.05";
            inputs.nixpkgs.follows = "nixpkgs";	
	};

	sops-nix.url = "github:Mic92/sops-nix";
        sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = inputs@{ self, nixpkgs, home-manager, sops-nix, ... }: {
	nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
	    system = "x86_64-linux";
	    specialArgs = { inherit inputs; };
	    modules = [
		./configuration.nix
		
		sops-nix.nixosModules.sops
		
		home-manager.nixosModules.home-manager {
		  home-manager.useGlobalPkgs = true;
		  home-manager.useUserPackages = true;
		  home-manager.users.anirudh = import ./home.nix;
		}
	    ];
	};
    };
}

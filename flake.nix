{
  description = "anirudh's nixos flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    claude-code.url = "github:sadjow/claude-code-nix";

    home-manager = {
      	url = "github:nix-community/home-manager";
      	inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, claude-code, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
	 ./configuration.nix
	 home-manager.nixosModules.home-manager {
	     environment.systemPackages = [ claude-code.packages.x86_64-linux.default ];
	
	     home-manager.useGlobalPkgs = true;
	     home-manager.useUserPackages = true;
	     home-manager.users.anirudh = import ./home-manager/home.nix;
         }
      ];
    };
  };
}

{
  description = "My first NixOS flake";

  inputs = {
 	# NixOS official package source, using the nixos-23.11 branch here
	nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
	home-manager = {
	  url = "github:nix-community/home-manager/release-24.05";
	  #this is to avoid problems with differnet versions of nixpkgs
	  inputs.nixpkgs.follows = "nixpkgs"; 
	};
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
    # Please replace nixos with your hostname
    nixosConfigurations.xps-13 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      #this is to pass inputs to all submodules of this configuration.
      specialArgs = { inherit inputs; }; 
      modules = [
       ./configuration.nix
	home-manager.nixosModules.home-manager
	{
	  home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;

	  home-manager.users.kissg = import ./home.nix;
	}
      ];
    };
    nixosConfigurations.xps-14 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      #this is to pass inputs to all submodules of this configuration.
      specialArgs = { inherit inputs; }; 
      modules = [
        ./configuration.nix
	home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.kissg = import ./home.nix;
        }
      ];
    };
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      #this is to pass inputs to all submodules of this configuration.
      specialArgs = { inherit inputs; }; 
      modules = [
        ./configuration.nix
	home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.kissg = import ./home.nix;
        }

      ];
    };
  };
}

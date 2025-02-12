{
  description = "Nixos Flake for configuration.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    apple-silicon-support = {
      url = "github:tpwrules/nixos-apple-silicon";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, apple-silicon-support, home-manager, nixvim, ... }@inputs: 
    let
    system = "aarch64-linux";
  pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    nixosConfigurations = {
      asahi = nixpkgs.lib.nixosSystem {
	inherit system;
	specialArgs = { inherit inputs; };
	modules = [
	  ./system/configuration.nix
	    /home/lilin/NixOS/secrets/eduroam.nix
	    apple-silicon-support.nixosModules.default
	];
      };
    };

    homeConfigurations = {
      lilin = home-manager.lib.homeManagerConfiguration {
	inherit pkgs;
	extraSpecialArgs = { inherit inputs; };
	modules = [
	  ./home/home.nix
	  ./HomeModules/oh-my-posh.nix
	  ./HomeModules/hyprland.nix
	  ./HomeModules/alacritty.nix
	  ./HomeModules/nvim
	];
      };
    };
  };
}

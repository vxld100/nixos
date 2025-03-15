{
  description = "Nixos Flake for configuration.";
  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";
    
      home-manager-unstable = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  
      home-manager-stable = {
        url = "github:nix-community/home-manager/release-24.11";
        inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    apple-silicon-support = {
      url = "github:tpwrules/nixos-apple-silicon";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { self, nixpkgs-unstable, nixpkgs-stable, 
           home-manager-unstable, home-manager-stable, 
           apple-silicon-support, nixvim, ... }@inputs: 

    let
      aarch64System = "aarch64-linux";
      x86_64System = "x86_64-linux";
      
      # Unstable packages for Asahi
      aarch64PkgsUnstable = nixpkgs-unstable.legacyPackages.${aarch64System};
      
      # Stable packages for datacenter
      x86_64PkgsStable = nixpkgs-stable.legacyPackages.${x86_64System};
    in
    {
      nixosConfigurations = {
        asahi = nixpkgs-unstable.lib.nixosSystem {
          system = aarch64System;
          specialArgs = { 
            nixpkgs = nixpkgs-unstable;
            inputs = inputs // { nixpkgs = nixpkgs-unstable; };
          };
          modules = [
            ./system/configuration.nix
            /home/lilin/NixOS/secrets/eduroam.nix
            apple-silicon-support.nixosModules.default
          ];
        };
        datacenter = nixpkgs-stable.lib.nixosSystem {
          system = x86_64System;
          specialArgs = { 
            nixpkgs = nixpkgs-stable;
            inputs = inputs // { nixpkgs = nixpkgs-stable; };
          };
          modules = [
            ./system/datacenter/configuration.nix
          ];
        };
      };

      homeConfigurations = {
        lilin = home-manager-unstable.lib.homeManagerConfiguration {
          pkgs = aarch64PkgsUnstable;
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./home/home.nix
            ./HomeModules/oh-my-posh.nix
            ./HomeModules/hyprland.nix
            ./HomeModules/alacritty.nix
            ./HomeModules/ghostty.nix
            ./HomeModules/yazi.nix
            ./HomeModules/zoxide.nix
            ./HomeModules/nvim
          ];
        };
        erebos = home-manager-stable.lib.homeManagerConfiguration {
          pkgs = x86_64PkgsStable;
          extraSpecialArgs = { 
	    inputs = inputs // { nixpkgs = nixpkgs-stable; };
	  };
          modules = [
            ./home/erebos/home.nix
            ./HomeModules/hyprland.nix
            ./HomeModules/oh-my-posh.nix
            ./HomeModules/ghostty.nix
            ./HomeModules/yazi.nix
            ./HomeModules/zoxide.nix
            ./HomeModules/nvim
          ];
        };
      };
    };
}

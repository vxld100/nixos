{
  description = "Nixos Flake for configuration.";

  inputs = {
    # NixOS official package source, using the nixos-23.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

	 home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };

	 apple-silicon-support = {
	 	url = "github:tpwrules/nixos-apple-silicon";
		inputs.nixpkgs.follows = "nixpkgs";
	 };
  };

  outputs = { nixpkgs, home-manager, apple-silicon-support,... }@inputs: 
  {
    nixosConfigurations = {
	 	asahi = nixpkgs.lib.nixosSystem {
			system = "aarch64-linux";
			specialArgs = { inherit inputs; };
			modules = [
			  ./system/configuration.nix

			  home-manager.nixosModules.home-manager {
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;

					home-manager.users.lilin = import ./home/home.nix;
			 }
			];
		 };
		};
  };
}

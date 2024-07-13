{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
  	with inputs;
	let
		specialArgs = { inherit inputs self; };
		systems = [ "x86_64-linux" ];
		eachSystem = inputs.nixpkgs.lib.genAttrs systems;
	in
	{
		nixosConfigurations = {
			arkannon = nixpkgs.lib.nixosSystem {
				inherit specialArgs;
				modules = [
					./configuration.nix
					home-manager.nixosModules.home-manager
					{
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;
						home-manager.users.arkannon = import ./home.nix;
						home-manager.extraSpecialArgs = specialArgs;
						home-manager.backupFileExtension = "backup";
					}
				];
			};
		};

		homeConfigurations = {
			"arkannon@arkannon" = home-manager.lib.homeManagerConfiguration {
				pkgs = nixpkgs.legacyPackages.x86_64-linux;
				unstable = unstable.legacyPackages.x86_64-linux;
				moduels = [
					./home.nix
				];
			};
		};
	};
}

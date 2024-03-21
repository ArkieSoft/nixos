{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    home-manager = { url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-citizen.url = "github:LovingMelody/nix-citizen";
    nix-gaming.url = "github:fufexan/nix-gaming";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs:
    with inputs;
    let
      specialArgs = { inherit inputs self; };
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
            }
          ];
        };
      };

      homeConfigurations = {
        "arkannon@arkannon" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          unstable = unstable.legacyPackages.x86_64-linux;
          modules = [
            ./home.nix
          ];
        };
      };
    };
}

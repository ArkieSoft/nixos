{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
  };

  outputs = inputs:
    with inputs;
    let
      specialArgs = { inherit inputs self; };
    in
    {
      nixosConfigurations = {
        ArkieLaptop = nixpkgs.lib.nixosSystem {
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
        "arkannon@ArkieLaptop" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [
            ./home.nix
          ];
        };
      };
    };
}

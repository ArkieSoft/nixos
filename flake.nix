{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-citizen.url = "github:LovingMelody/nix-citizen";
    nix-gaming.url = "github:fufexan/nix-gaming";
    stable.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs:
    with inputs;
    let
      specialArgs = { inherit inputs self; };
      systems = [ "x86_64-linux" "aarch64-darwin" ];
      eachSystem = inputs.nixpkgs.lib.genAttrs systems;
    in
    {
      nixosConfigurations = {
        arkannon = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = [
            ./configuration.nix
            #nixos-cosmic.nixosModules.default
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
          modules = [
            ./home.nix
          ];
        };
      };
      formatter = eachSystem (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        pkgs.nixpkgs-fmt
      );
    };
}

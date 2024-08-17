{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin-custom-icons.url = "github:ryanccn/nix-darwin-custom-icons";
  };

  outputs =
    inputs@{ self
    , nixpkgs
    , nixos-cosmic
    , home-manager
    , nix-darwin
    , darwin-custom-icons
    , ...
    }:
    {
      nixosConfigurations = {
        arkannon = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            {
              nix.settings = {
                substituters = [ "https://cosmic.cachix.org/" ];
                trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
              };
            }
            nixos-cosmic.nixosModules.default
            ./arkannon/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.arkannon = import ./arkannon/home.nix;
                extraSpecialArgs = { inherit self inputs; };
                backupFileExtension = "backup";
              };
            }
          ];
        };

        mailserver = nixpkgs.lib.nixosSystem {
          system = "x86-64-linux";
          modules = [
            ./mailserver/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.wyatt = import ./mailserver/home.nix;
                extraSpecialArgs = { inherit self inputs; };
                backupFileExtension = "backup";
              };
            }
          ];
        };
      };

      darwinConfigurations."arkmac" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./arkmac/configuration.nix
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.arkannon = import ./arkmac/home.nix;
              extraSpecialArgs = { inherit self inputs; };
            };
          }
          darwin-custom-icons.darwinModules.default
        ];
      };
      formatter = {
        x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
        aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixpkgs-fmt;
      };
    };
}

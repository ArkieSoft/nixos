{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim-unstable = {
      url = "github:nix-community/nixvim/main";
      inputs.nixpkgs.follows = "unstable";
    };
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager-unstable = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin-custom-icons.url = "github:ryanccn/nix-darwin-custom-icons";
    nix-citizen.url = "github:LovingMelody/nix-citizen";
    nix-gaming.url = "github:fufexan/nix-gaming";
    nix-citizen.inputs.nix-gaming.follows = "nix-gaming";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs =
    inputs@{ self
    , nixpkgs
    , sops-nix
    , nixos-cosmic
    , home-manager
    , nix-darwin
    , unstable
    , home-manager-unstable
    , darwin-custom-icons
    , nix-gaming
    , nix-citizen
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
        cloudserver = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./cloudserver/configuration.nix
            sops-nix.nixosModules.sops
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.wyatt = import ./cloudserver/home.nix;
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
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixpkgs-fmt;
    };
}

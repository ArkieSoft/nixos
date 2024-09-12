{ config, pkgs, inputs, ... }:
{

  imports = [
    ./bash.nix
    ../modules/nixvim.nix
    ../modules/git.nix
  ];

  home = {
    username = "wyatt";
    homeDirectory = "/home/wyatt";
    stateVersion = "24.05";
    sessionVariables = {
      EDITOR = "nvim";
    };
    packages = with pkgs; [
      gh
      git
      gcc
      nixpkgs-fmt
      (callPackage ./ass.nix { })

    ];
  };

  programs = {
    home-manager.enable = true;
  };
}

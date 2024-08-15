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
    ];
  };

  programs = {
    home-manager.enable = true;
  };
}

{ self, config, pkgs, inputs, ... }:
{
  imports = [
    ../modules/nixvim.nix
    ../modules/git.nix
    ./bash.nix
  ];

  programs = {
    home-manager.enable = true;
    zoxide = {
      enable = true;
      enableBashIntegration = true;
    };
  };

  home = {
    username = "wyatt";
    homeDirectory = "/home/wyatt";
    stateVersion = "24.05";
    sessionVariables = {
      EDITOR = "nvim";
    };

    packages = with pkgs; [
      gcc
      eza
      (callPackage ./ass.nix { })
    ];
  };
}

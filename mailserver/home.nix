{ config, pkgs, inputs, ... }:
{

  imports = [
    ./bash.nix
    ../modules/nixvim.nix
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
    git = {
      enable = true;
      userEmail = "wyatt@arkannon.com";
      userName = "ArkieSoft@Github";
      extraConfig = {
        credential.helper = "${
          pkgs.git.override { withLibsecret = true; }
          }/bin/git-credential-libsecret";
        };
    };
  };
}

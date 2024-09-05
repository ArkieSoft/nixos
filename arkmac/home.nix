{ pkgs, ... }:
{
  imports = [
    ./bash.nix
    ../modules/nixvim.nix
  ];

  home = {
    stateVersion = "24.05";
    packages = with pkgs; [
      (callPackage ../modules/ass.nix { })
      crosswords
      flameshot
      libreoffice-bin
      gomuks
      gh
      chafa
      neofetch
      oh-my-posh
      btop
      rustup
      discord
      cowsay
      lolcat
      sox
      figlet
      eza
    ];

    file = {
      "assets" = {
        source = ../assets;
        recursive = true;
        target = "nix/assets/";
      };

      "sounds" = {
        source = ../sounds;
        recursive = true;
        target = "nix/sounds/";
      };

      "fetchart" = {
        source = ../fetchart;
        recursive = true;
        target = "nix/fetchart";
      };


    };
  };

  programs = {
    zoxide = {
      enable = true;
      enableBashIntegration = true;
    };
    git = {
      enable = true;
      userName = "github@ArkieSoft";
      userEmail = "wyatt@arkannon.com";
    };
    kitty = {
      enable = true;
      font.name = "CaskaydiaCove Nerd Font Mono";
      settings = {
        shell = "/etc/profiles/per-user/arkannon/bin/bash";
        editor = "nvim";
        background = "#181818";
        confirm_os_window_close = 0;
      };
    };
  };

}

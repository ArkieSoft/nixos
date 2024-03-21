{ config, pkgs, inputs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  
  wayland.windowManager.hyprland = import ./hyprland.nix;

  programs = {
    bash = import ./bash.nix;
#  programs.oh-my-posh = import ./posh.nix;
    waybar = import ./waybar.nix;
    rofi = import ./rofi.nix;
    git = {
      enable = true;
      userEmail = "wyatt@arkannon.com";
      userName = "ArkieSoft@Github";
    };
    home-manager.enable = true;
  };

  services.dunst = import ./dunst.nix;

  gtk = {
    enable = true;
    theme = {
      package = pkgs.qogir-theme;
      name = "Qogir-Dark";
    };
    iconTheme = {
      package = pkgs.qogir-icon-theme;
      name = "Qogir-dark";
    };
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
    };
  };
 
  home = {
    username = "arkannon";
    homeDirectory = "/home/arkannon";
    sessionVariables = {
      EDITOR = "neovim";
      BROWSER = "firefox";
    };

    packages = with pkgs; [
      git
      gh
      inputs.nix-citizen.packages.${system}.lug-helper
      inputs.nix-citizen.packages.${system}.star-citizen-helper
      inputs.nix-citizen.packages.${system}.star-citizen
      steam-tui
      parsec-bin
      libsForQt5.dolphin
      steamcmd
      gnumake
      python311Packages.pip
      nodejs_21
      audacity
      ripgrep
      python3
      gcc
      git-credential-manager
      discord
      ranger
      webcord
      lutris
      steam-run
      protonup-qt
      wl-clipboard
      protonvpn-cli
      oh-my-posh
      alacritty
      neofetch
      gimp
      xfce.thunar
      xfce.thunar-volman
      appimage-run
      xfce.thunar-archive-plugin
      thunderbird
      #vesktop
      nicotine-plus
      #chromium
      nwg-look
      wdisplays
      hyprpaper
      btop
      signal-desktop
      vlc
      curl
      #llvmPackages.bintools
      rustup
      libsForQt5.ark
      swww
      bottles
      nextcloud-client
      obs-studio
      pavucontrol
      winetricks
      wine-staging
      wine
      wl-clipboard
      grimblast
    ];
  };
}

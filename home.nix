{ config, pkgs, inputs, ... }:
{
  imports = [
    modules/hyprland.nix
    modules/bash.nix
    modules/dunst.nix
    modules/waybar.nix
    modules/git.nix
    modules/nixvim.nix
  ];

  programs = {
    home-manager.enable = true;
    kitty = {
      enable = true;
      settings = {
        background = "#181818";
        confirm_os_window_close = 0;
      };
    };
    obs-studio = {
      enable = true;
      plugins = with pkgs; [
        obs-studio-plugins.wlrobs
        obs-studio-plugins.obs-vkcapture
      ];
    };
    zoxide = {
      enable = true;
      enableBashIntegration = true;
    };
  };
  
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
    stateVersion = "24.05";
    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "firefox";
    };

    packages = with pkgs; [
      manix
      mtr #Network Diagnostics Tool
      nomacs #Lightweight image viewer
      fastfetch
      cowsay
      lolcat
      eza
      gomuks
      gh
      vesktop
      parsec-bin
      telegram-desktop
      ripgrep
      lutris
      steam
      protonup-qt
      wl-clipboard
      oh-my-posh
      neofetch
      gimp
      sox #Terminal sound player for Hydro.sh. Provides 'play' command
      thunderbird
      nicotine-plus
      nwg-panel
      btop
      signal-desktop
      vlc
      curl
      rustup
      libsForQt5.ark
      swww
      nextcloud-client
      pavucontrol
      winetricks
      prettyping
      wine-staging
      wine
      grimblast
    ];
  };
}

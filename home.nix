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
        #obs-studio-plugins.obs-webkitgtk
        obs-studio-plugins.obs-vkcapture

      ];
    };
    zoxide = {
      enable = true;
      enableBashIntegration = true;
    };
    #neovim = {
    #  enable = true;
    #  defaultEditor = true;
    #};
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
      iamb
      manix
      mtr
      nomacs
      fastfetch
      helvum
      bsdgames
      cowsay
      lolcat
      eza
      emacs
      gomuks
      gh
      vesktop
      #inputs.nix-citizen.packages.${system}.lug-helper
      #inputs.nix-citizen.packages.${system}.star-citizen-helper
      #inputs.nix-citizen.packages.${system}.star-citizen
      parsec-bin
      gnumake
      telegram-desktop
      python311Packages.pip
      ripgrep
      python3
      gcc
      lutris
      steam
      protonup-qt
      wl-clipboard
      oh-my-posh
      neofetch
      gimp
      xfce.thunar
      sox
      xfce.thunar-volman
      xfce.thunar-archive-plugin
      thunderbird
      nicotine-plus
      nwg-look
      nwg-panel
      wdisplays
      btop
      signal-desktop
      vlc
      curl
      rustup
      libsForQt5.ark
      libreoffice
      swww
      nextcloud-client
      pavucontrol
      winetricks
      prettyping
      wine-staging
      wine
      grimblast
      ventoy
    ];
  };
}

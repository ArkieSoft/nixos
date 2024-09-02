{ self, config, pkgs, inputs, ... }:
{
  imports = [
    ../modules/hyprland.nix
    ./bash.nix
    ../modules/dunst.nix
    ../modules/waybar.nix
    ../modules/git.nix
    ../modules/nixvim.nix
  ];

  programs = {
    password-store.enable = true;
    oh-my-posh = {
      enable = true;
      enableFishIntegration = true;
    };
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
        obs-studio-plugins.obs-backgroundremoval

      ];
    };
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
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
      XDG_SCREENSHOT_DIR = "~/Pictures";
    };

    packages = with pkgs; [
      (callPackage ../modules/ass.nix {})
      termsonic
      termusic
      ryujinx
      crosswords
      chafa
      manix
      rofi-wayland
      figlet
      mtr #Network Diagnostics Tool
      xfce.thunar
      fastfetch
      cowsay
      lolcat
      eza
      yt-dlp
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
}

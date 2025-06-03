{ self, config, pkgs, inputs, ... }:
{
  imports = [
    ../modules/hyprland.nix
    ./bash.nix
    ../modules/dunst.nix
    ../modules/waybar.nix
    ../modules/git.nix
    ../modules/nixvim.nix
    ./packages.nix
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
    };
  };

  xdg = {
    portal.extraPortals = [
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gtk
    ];
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = "librewolf";
        "scheme-handler/http" = "librewolf";
        "scheme-handler/https" = "librewolf";
        "x-scheme-handler/http" = "librewolf";
        "x-scheme-handler/https" = "librewolf";
        "inode/directory" = "thunar";
      };
    };
#configFile = {
#      "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
#      "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
#    };
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
      GTK_THEME = "Qogir-Dark";
      EDITOR = "nvim";
      BROWSER = "librewolf";
      XDG_SCREENSHOT_DIR = "~/Pictures";
#XDG_DATA_DIRS = "/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share";
    };
    
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

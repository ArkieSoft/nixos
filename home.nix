{ config, pkgs, inputs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "arkannon";
  home.homeDirectory = "/home/arkannon";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.
 
  

  
  wayland.windowManager.hyprland = import ./hyprland.nix;

  programs.bash = import ./bash.nix;
#  programs.oh-my-posh = import ./posh.nix;
  programs.waybar = import ./waybar.nix;
  services.dunst = import ./dunst.nix;
  programs.rofi = import ./rofi.nix;
  programs.git = {
    enable = true;
    userEmail = "wyatt@arkannon.com";
    userName = "ArkieSoft@Github";
  };
  #xsession.windowManager.i3 = import ./i3.nix;



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


  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
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
    vesktop
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

  



# # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/arkannon/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "neovim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

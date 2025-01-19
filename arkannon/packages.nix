{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (callPackage ../modules/ass.nix { })
    #inputs.nix-citizen.packages.${system}.star-citizen
    #inputs.nix-citizen.packages.${system}.star-citizen-helper
    #inputs.nix-citizen.packages.${system}.lug-helper
    gcc
    qbittorrent
    libreoffice
    hugo
    prismlauncher
    heroic
    ryujinx
    crosswords
    chafa
    rofi-wayland
    figlet
    mtr #Network Diagnostics Tool
    xfce.thunar
    cowsay
    lolcat
    eza
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
    chirp
    pokemmo-installer
    python3Full
    python3Packages.pip
    python3Packages.pipx
  ];

}

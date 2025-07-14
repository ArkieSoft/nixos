{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (callPackage ../modules/ass.nix { })
    #inputs.nix-citizen.packages.${system}.star-citizen
    #inputs.nix-citizen.packages.${system}.star-citizen-helper
    #inputs.nix-citizen.packages.${system}.lug-helper
    #unstable.teamspeak6-client
    openscad
    freecad-wayland
    supersonic
    manix
    qbittorrent
    libreoffice
    prismlauncher
    chiaki-ng
    heroic
    chafa
    rofi-wayland
    xfce.thunar
    gh
    vesktop
    telegram-desktop
    ripgrep
    lutris
    steam
    protonup-qt
    wl-clipboard
    neofetch
    gimp
    thunderbird
    nicotine-plus
    nwg-panel
    btop
#    signal-desktop
    vlc
    libsForQt5.ark
    swww
    nextcloud-client
    pavucontrol
    winetricks
    wine-staging
    wine
    grimblast
    tmux
    emacs-pgtk
    mgba
    prusa-slicer
    kicad
    moonlight-qt
    picard
    librewolf
    wonderdraft
  ];

}

{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    (callPackage ../modules/ass.nix { })
    (callPackage ../modules/edhm_ui.nix { })
    #inputs.nix-citizen.packages.${system}.star-citizen
    #inputs.nix-citizen.packages.${system}.star-citizen-helper
    #inputs.nix-citizen.packages.${system}.lug-helper
    #unstable.teamspeak6-client
    jellyfin-media-player
    min-ed-launcher
    supersonic
    manix
    qbittorrent
    libreoffice
    heroic
    chafa
    rofi
    xfce.thunar
    gh
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
    kdePackages.ark
    swww
    nextcloud-client
    pavucontrol
    winetricks
    wine-staging
    wine
    grimblast
    tmux
    mgba
    prusa-slicer
    moonlight-qt
    picard
    librewolf
    wonderdraft
    kdePackages.kdenlive
    cosmic-ext-tweaks
    quick-webapps
  ];

}

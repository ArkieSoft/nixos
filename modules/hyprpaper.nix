{ config, pkgs, ...}:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = true;
      preload = [ "/etc/nixos/wallpapers/*" ];
    };
  };
}

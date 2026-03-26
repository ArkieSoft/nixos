{ config, pkgs, ...}:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
      };
      background = [
        {
          blur_passes = 2;
          blur_suze = 5;
          path = "/etc/nixos/wallpapers/nyx.jpg";
        }
      ];
      image = [
        {
          monitor = "DP-2";
          size = 300;
          path = "/etc/nixos/assets/popcat.png";
        }
      ];
      input-field = [
        {
          monitor = "DP-2";
          size = "200, 45";
          capslock_color = "rgba(255,189,68,1.0)";
          fade_on_empty = false;
          position = "0, -300";
        }
      ];

      label = [
        {
          monitor = "DP-2";
          color = "rgba(255,102,178,1.0)";
          font_family = "CaskaydiaCoveNerdFont";
          font_size = 40;
          position = "0, 300";
          text = "Arkannon's PC";
        }
      ];
    };
  };
}

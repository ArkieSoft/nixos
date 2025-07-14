{ config, pkgs, ...}:
{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
          lock_cmd = "hyprlock";
      };

      listener = [
        {
          timeout = 300;
          on-timeout = "hyprlock";
        }
      ];
    };
  };
}

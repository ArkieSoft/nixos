{ config, pkgs, ... }:
{  
  services = {
    searx = {
      enable = true;
      environmentFile = /home/wyatt/searxng-key;
      settings = {
        server.port = 5090;
        server.bind.address = "0.0.0.0";
        server.secret_key = "${config.services.searx.environmentFile}";
      };
    };

    ollama = {
      enable = true;
    };

#    nextjs-ollama-llm-ui.enable = true;
#    whoogle-search = {
#      enable = true;
#      port = 4100;
#    };

    lidarr = {
      enable = true;
      user = "nextcloud";
      group = "nextcloud";
      openFirewall = true;
    };
    radarr = {
      enable = true;
      user = "nextcloud";
      group = "nextcloud";
      openFirewall = true;
    };
    sonarr = {
      enable = true;
      user = "nextcloud";
      group = "nextcloud";
      openFirewall = true;
    };
    prowlarr = {
      enable = true;
      openFirewall = true;
    };
    xserver = {
      xkb = {
        layout = "us";
        variant = "";
      };
    };
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
    };
    navidrome = {
      enable = true;
      openFirewall = true;
      user = "nextcloud";
      settings = {
        MusicFolder = "/storage/Music";
        EnableSharing = "true";
      };
    };

    jellyfin = {
      enable = true;
      openFirewall = true;
    };
  };
}

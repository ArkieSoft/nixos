{ config, pkgs, ... }:
{  
  services = {
#    telegraf.enable = true;
    ntfy-sh = {
      enable = true;
      settings = {
        listen-http = ":3040";
        base-url = "https://ntfy.arkannon.com";
      };
    };
    glance = {
      enable = true;
      openFirewall = true;
      settings.port = 8086;
    };
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
#  teamspeak3 = {
#   enable = true;
#      openFirewall = true;
#      dataDir = /storage/teamspeak3;
#    };
    grafana = {
      enable = true;
      settings = {
        server = {
          http_addr = "127.0.0.1";
          http_port = 3420;
          domain = "graf.arkannon.com";
        };
      };
    };
  };
}

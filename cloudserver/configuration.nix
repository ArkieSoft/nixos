# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix

    ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "cloudserver";
    networkmanager.enable = true;
    nameservers = [ "8.8.8.8" "8.8.4.4" ];
    firewall = {
      allowedTCPPorts = [ 80 443 ];
      allowedUDPPorts = [ 80 443 ];
      enable = true;
    };
  };
  
  time.timeZone = "America/Los_Angeles";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };


  systemd.services.qbittorrent = {
    enable = true;
    description = "qBittorrent-nox service";
    wants = [ "network-online.target" ];
    after = [ "network-online.target" "nss-lookup.target" ];
    path = [ "pkgs.nix" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "exec";
      User = "nextcloud";
      ExecStart = "/run/current-system/sw/bin/qbittorrent-nox";
    };
  };

  services = {
    glance = {
      enable = true;
      openFirewall = true;
      settings.port = 8086;
    };
#    pufferpanel = {
#      enable = true;
#      environment = {
#        PUFFER_WEB_HOST = ":8088";
#        PUFFER_DAEMON_SFTP_HOST = ":5657";
#        PUFFER_DAEMON_CONSOLE_BUFFER = "1000";
#        PUFFER_DAEMON_CONSOLE_FORWARD = "true";
#        PUFFER_PANEL_REGISTRATIONENABLED = "false";
#      };
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
    nextcloud = {
      enable = true;
      package = pkgs.nextcloud30;
      hostName = "cloud.arkannon.com";
      https = true;
      configureRedis = true;
      maxUploadSize = "20G";
      config = {
        adminpassFile = "/etc/nextcloud-admin-pass";
        adminuser = "admin";
      };
      settings = {
        log_type = "file";
      };
      extraAppsEnable = true;
      extraApps = {
        inherit (pkgs.nextcloud30Packages.apps) calendar contacts notes news;
        cookbook = pkgs.fetchNextcloudApp {
          sha256 = "sha256-upbTdzu17BH6tehgCUcTxBvTVOO31Kri/33vGd4Unyw=";
          url = "https://github.com/christianlupus-nextcloud/cookbook-releases/releases/download/v0.11.2/cookbook-0.11.2.tar.gz";
          license = "agpl3Only";
        };
        picker = pkgs.fetchNextcloudApp {
          sha256 = "sha256-v/CoSNPoiasaEyZRbSnJTwcXBDOjCHvaPVP3f6keoss=";
          url = "https://github.com/nextcloud-releases/picker/releases/download/v1.0.10/picker-v1.0.10.tar.gz";
          license = "agpl3Only";
        };
        pride_flags = pkgs.fetchNextcloudApp {
          sha256 = "sha256-AC1DsCHzKVhXtYStSRBDFGgRHlK4WUegAJ5m5mr02yo=";
          url = "https://git.finally.coffee/finallycoffee/nextcloud-pride-flags/releases/download/1.1.1/pride_flags-1.1.1.tar.gz";
          license = "gpl3";
        };
        secrets = pkgs.fetchNextcloudApp {
          sha256 = "sha256-tTe6mS1aaLZRACUhGgEINKzhz+vNigPcVTtEY87mQQQ=";
          url = "https://github.com/theCalcaholic/nextcloud-secrets/releases/download/v2.1.1/secrets.tar.gz";
          license = "agpl3Only";
        };
        permissions_overwrite = pkgs.fetchNextcloudApp {
          sha256 = "sha256-qDLmHzLO0PnUT0DSk+U8KvkQKKR/56rZQxuK9FTOtEc=";
          url = "https://github.com/icewind1991/permissions_overwrite/releases/download/v0.1.13/permissions_overwrite-v0.1.13.tar.gz";
          license = "agpl3Only";
        };
        spreed = pkgs.fetchNextcloudApp {
          sha256 = "sha256-mUJmbOMMIkm/83a+7xcW59TTar58D4l0Ek+kZoRdxG8=";
          url = "https://github.com/nextcloud-releases/spreed/releases/download/v20.0.1/spreed-v20.0.1.tar.gz";
          license = "agpl3Only";
        };
        externalportal = pkgs.fetchNextcloudApp {
          sha256 = "sha256-Bdhx6xHzoYi4na8w4g4Nwlg5/GqwqRiHPtfQ2P9sUR8=";
          url = "https://github.com/puavo-org/externalportal/releases/download/v1.3.1/externalportal.tar.gz";
          license = "agpl3Only";
        };
        bookmarks = pkgs.fetchNextcloudApp {
          sha256 = "sha256-F3r+FU5m9vj13bhJqGi7cCtZUxAIL453QUu1y65Ty/I=";
          url = "https://github.com/nextcloud/bookmarks/releases/download/v15.0.2/bookmarks-15.0.2.tar.gz";
          license = "agpl3Only";
        };
#       passwords = pkgs.fetchNextcloudApp {
#         sha256 = "sha256-L+jumcussL0c9xNMg/GMs1GSd1IY9wUvC8ZEg+3U+sc=";
#          url = "https://git.mdns.eu/api/v4/projects/45/packages/generic/passwords/2024.9.0/passwords.tar.gz";
#          license = "agpl3Only";
#        };
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

    nginx = {
      virtualHosts = {
        ${config.services.nextcloud.hostName} = {
          forceSSL = true;
          enableACME = true;
        };
        "music.arkannon.com" = {
          forceSSL = true;
          enableACME = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:4533";
            proxyWebsockets = true;
          };
        };
        "jf.arkannon.com" = {
          forceSSL = true;
          enableACME = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:8096";
            proxyWebsockets = true;
          };
        };
        "arkannon.com" = {
          root = "/var/www/homepage/public";
          forceSSL = true;
          enableACME = true;
          serverAliases = [
            "www.arkannon.com"
            "arkannon.com"
          ];
          locations."/" = {
            index = "index.html";
          };
        };
        "indexarr.arkannon.com" = {
          forceSSL = true;
          enableACME = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:9696";
            proxyWebsockets = true;
          };
        };
        "qt.arkannon.com" = {
          forceSSL = true;
          enableACME = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:3000";
            proxyWebsockets = true;
            extraConfig = ''
              proxy_set_header   Host               $proxy_host;
              proxy_set_header   X-Forwarded-For    $proxy_add_x_forwarded_for;
              proxy_set_header   X-Forwarded-Host   $http_host;
              proxy_set_header   X-Forwarded-Proto  $scheme;
            '';
          };
        };
        "lidarr.arkannon.com" = {
          forceSSL = true;
          enableACME = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:8686";
            proxyWebsockets = true;
          };
        };
        "sonarr.arkannon.com" = {
          forceSSL = true;
          enableACME = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:8989";
            proxyWebsockets = true;
          };
        };
        "radarr.arkannon.com" = {
          forceSSL = true;
          enableACME = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:7878";
            proxyWebsockets = true;
          };
        };
        "start.arkannon.com" = {
          forceSSL = true;
          enableACME = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:8080";
            proxyWebsockets = true;
          };
        };
      };
    };
  };
  
  security.acme = {
    acceptTerms = true;
    defaults.email = "certs@arkannon.com";
  };
  
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  users.users.wyatt = {
    isNormalUser = true;
    description = "wyatt";
    extraGroups = [ "networkmanager" "wheel" "root" "dialout" "docker" "podman" ];
    packages = with pkgs; [ ];
  };

  fileSystems."/storage" = {
    device = "/dev/disk/by-uuid/5f86d5fd-c05e-4332-b5b1-2fada5e5e045";
    fsType = "ext4";
    options = [
      "users"
      "nofail"
      "auto"
      "exec"
      "rw"
    ];
  };

 fileSystems."/var/lib/nextcloud/data" = {
    device = "/dev/disk/by-uuid/efb684de-de0e-4969-915d-688dc1ed73f2";
    fsType = "ext4";
    options = [
      "users"
      "nofail"
      "auto"
      "exec"
      "rw"
    ];
  };

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "qbittorrent-nox-4.6.4"
      "aspnetcore-runtime-wrapped-6.0.36"
      "aspnetcore-runtime-6.0.36"
      "dotnet-sdk-wrapped-6.0.428"
      "dotnet-sdk-6.0.428"
    ];
  };

  environment = {
    systemPackages = with pkgs; [
      komga
      pufferpanel
      jellyfin
      jellyfin-web
      jellyfin-ffmpeg
      hugo
      qbittorrent-nox
      neovim
      age
    ];
#etc."nextcloud-admin-pass".source = /home/wyatt/admin-pass;
    etc."nextcloud-admin-pass".text = builtins.readFile ../../../../home/wyatt/admin-pass;
  };
  system.stateVersion = "24.05";
}

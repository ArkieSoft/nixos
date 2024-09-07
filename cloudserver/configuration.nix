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

  services = {
    xserver = {
      layout = "us";
      xkbVariant = "";
    };
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "yes";
      };
    };
    nextcloud = {
      enable = true;
      package = pkgs.nextcloud29;
      hostName = "cloud.arkannon.com";
      https = true;
      configureRedis = true;
      maxUploadSize = "20G";
      config = {
        adminpassFile = "/etc/nextcloud-admin-pass";
        adminuser = "admin";
      };
      extraAppsEnable = true;
      extraApps = {
        inherit (pkgs.nextcloud29Packages.apps) calendar contacts notes;
        cookbook = pkgs.fetchNextcloudApp {
          sha256 = "sha256-a8ekMnEzudHGiqHF53jPtgsVTOTc2QLuPg6YtTw5h68=";
          url = "https://github.com/christianlupus-nextcloud/cookbook-releases/releases/download/v0.11.1/cookbook-0.11.1.tar.gz";
          license = "agpl3Only";
        };
        picker = pkgs.fetchNextcloudApp {
          sha256 = "sha256-JrNhQQYTRqaQTnurOMz5643UeXxNhrkciJkEAXm90Vg=";
          url = "https://github.com/nextcloud-releases/picker/releases/download/v1.0.10/picker-v1.0.10.tar.gz";
          license = "agpl3Only";
        };
        pride_flags = pkgs.fetchNextcloudApp {
          sha256 = "zsfSFv6CBkblT17CIf8j+wjtVfvxDazXlQZBGyDO5xA=";
          url = "https://git.finally.coffee/finallycoffee/nextcloud-pride-flags/releases/download/1.1.0/pride_flags-1.1.0.tar.gz";
          license = "gpl3";
        };
        secrets = pkgs.fetchNextcloudApp {
          sha256 = "sha256-axIQet26lRAq3Ww8K8txKu6tB7kuWHilCcSLHZxq0Ug=";
          url = "https://github.com/theCalcaholic/nextcloud-secrets/releases/download/v2.0.3/secrets.tar.gz";
          license = "agpl3Only";
        };
      };
    };
    
    navidrome = {
      enable = true;
      openFirewall = true;
      user = "nextcloud";
      settings = {
        MusicFolder = "/var/lib/nextcloud/data/admin/files/Music";
      };
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
      };
    };
  };

  security.acme = {
  acceptTerms = true;
  certs = {
   ${config.services.nextcloud.hostName}.email = "certs@arkannon.com";
   "music.arkannon.com".email = "certs@arkannon.com";
  };
 };
  
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
  };
  
  users.users.wyatt = {
    isNormalUser = true;
    description = "wyatt";
    extraGroups = [ "networkmanager" "wheel" "root" "dialout" ];
    packages = with pkgs; [ ];
  };

  fileSystems."/var/lib/nextcloud/data" = {
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

  nixpkgs.config.allowUnfree = true;

  environment = {
    systemPackages = with pkgs; [
    ];
    etc."nextcloud-admin-pass".source = /home/wyatt/admin-pass;
  };

  system.stateVersion = "24.05";
}

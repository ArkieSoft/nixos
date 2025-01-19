# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./nginx.nix
      ./nextcloud.nix
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

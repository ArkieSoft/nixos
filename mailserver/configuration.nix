{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./mailserver.nix
    ];

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
  };

  networking = {
    hostName = "mailserver";
    networkmanager.enable = true;
    interfaces.ens18.ipv4.addresses = [{
      address = "23.150.41.185";
      prefixLength = 24;
    }];
    defaultGateway = "23.150.41.161";
    nameservers = [ "156.154.132.200" ];
    firewall = {
      allowedTCPPorts = [ 22 25 80 443 ];
      allowedUDPPorts = [ 22 25 ];
    };
  };

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      cores = 1;
    };
  };

  time.timeZone = "America/Chicago";

  users.users.wyatt = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  services = {
    openssh = {
      enable = true;
      openFirewall = true;
    };
    roundcube = {
      enable = true;
      hostName = "webmail.arkannon.com";
      extraConfig = ''
        $config['smtp_server'] = "tls://${config.mailserver.fqdn}";
        $config['smtp_user'] = "%u";
        $config['smtp_pass'] = "%p";
      '';
    };
    nginx.enable = true;
  };

  system.stateVersion = "24.05";

}


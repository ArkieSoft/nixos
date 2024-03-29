# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  
  nixpkgs.config = {
    allowUnfree = true;
  };


  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [ "amd_iommu=on" ]; # Enables PCI-Passthrough
    blacklistedKernelModules = [ "nvidia" "nouveau" ];  #Turns off Nvidia drivers
    kernelModules = [ "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio" "v4l2loopback" ]; #Enables PCI Passthrough modules and 'v4l2loopback' for virtual cam on OBS
    extraModprobeConfig = ''options vfio-pci ids=10de:1b06,10de:10ef 
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
      ''; #Links Virtual PCI drivers to Nvidia card and enables V4l2loopback drivers to make a camera
    kernel.sysctl = { "vm.max_map_count" = 16777216; }; #For Star Citizen
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
  };

  swapDevices = [ { 
      device = "/var/lib/swapfile";
      size = 16*1024;
    } 
  ];

  networking = {
    hostName = "arkannon"; # Define your hostname.
    networkmanager.enable = true;
    firewall.enable = false;
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    pam.services.arkannon = {
      enableGnomeKeyring = true;
    };
  };

  virtualisation = { #Allows virt-manager to work with QEMU backend
    spiceUSBRedirection.enable = true;
    libvirtd = {
      enable = true;
      qemu.swtpm.enable = true;

    };
  };
  programs = {
    virt-manager.enable = true;
    steam.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      enableBrowserSocket = true;
      enableExtraSocket = true;
      pinentryFlavor = "gnome3";
    };
    hyprland = {
  	  enable = true;
  	  xwayland.enable = true;
    };
    firefox = {
      enable = true;
      preferences = {
        "widget.use-xdg-desktop-portal.file-picker" = 1;
      };
    };    
    ssh.startAgent = false;
    neovim = {
	    enable = true;
	    defaultEditor  = true;
    };
  }; 

  services = {
    gnome.gnome-keyring.enable = true;
    pipewire = {
  	  enable = true;
  	  alsa.enable = true;
  	  alsa.support32Bit = true;
  	  pulse.enable = true;
      wireplumber.enable = true;
    };
    gvfs.enable = true; #For Thunar auto-mount
    tumbler.enable = true;
	  openssh.enable = true;
    dbus.enable = true;
    xserver = {
      enable = true;
      xrandrHeads = [ { output = "DP-2"; primary = true; } ];
      xkb = {
        variant = "";
        layout = "us";
      };
    };

  };
  
  xdg = {
    portal = {
      wlr.enable = true;
      xdgOpenUsePortal = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal-gtk
      ];
      config.common.default = "*";
    };
    mime.defaultApplications = {
      "text/html" = "firefox";
      "x-scheme-handler/http" = "firefox";
      "x-scheme-handler/https" = "firefox";
    };
  };
  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
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
  
  fonts.packages = with pkgs; [
	  nerdfonts
  ];

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.bash;
    users.arkannon = {
      isNormalUser = true;
      description = "arkannon";
      extraGroups = [ "networkmanager" "wheel" "libvirtd" "kvm" ];
      packages =  [
	    ];
    };
  };
  # $ nix search wget
  environment = {
    systemPackages = with pkgs; [
	    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
	    wget
      mesa
      dxvk
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };


  # Open ports in the firewall.
  #networking.firewall.allowedTCPPorts = [ 2300 2301 2303 ];
  #networking.firewall.allowedUDPPorts = [ 2300 2301 2303 ];
  # Or disable the firewall altogether.

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}

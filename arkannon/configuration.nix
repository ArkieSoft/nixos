{ self, config, pkgs, lib, inputs, ... }:
{
  imports =
    [
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
    initrd.kernelModules = [ "amdgpu" ];
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [ "amd_iommu=on" ]; # Enables PCI-Passthrough
    blacklistedKernelModules = [ "nvidia" "nouveau" ]; #Turns off Nvidia drivers
    kernelModules = [ "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio" "v4l2loopback" ]; #Enables PCI Passthrough modules and 'v4l2loopback' for virtual cam on OBS
    extraModprobeConfig = ''options vfio-pci ids=10de:1b06,10de:10ef 
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
      ''; #Links Virtual PCI drivers to Nvidia card and enables V4l2loopback drivers to make a camera
    kernel.sysctl = { "vm.max_map_count" = 16777216; }; #For Star Citizen
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
  };

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 16 * 1024;
  }];

  networking = {
    hostName = "arkannon"; # Define yourromoZZhostname.
    networkmanager.enable = true;
    firewall.enable = false;
    bridges = {
      br0 = {
        interfaces = [
          "enp6s0"
        ];
      };
    };
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    pam.services.arkannon = {
      enableGnomeKeyring = true;
    };
  };

  virtualisation = {
    #Allows virt-manager to work with QEMU backend
    spiceUSBRedirection.enable = true;
    libvirtd = {
      enable = true;
      qemu.swtpm.enable = true;

    };
  };
  programs = {
    dconf.enable = true;
    virt-manager.enable = true;
    nh = {
      enable = true;
      flake = "/etc/nixos/";
    };
    steam = {
      enable = true;
      extest.enable = true;
      remotePlay.openFirewall = true;
    };
    gnupg.agent = {
      enable = true;
      enableSSHSupport = false;
      enableBrowserSocket = true;
      enableExtraSocket = true;
      #pinentryFlavor = "gnome3";
    };
    hyprland = {
      enable = true;
      xwayland.enable = true;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };
    ssh = {
      startAgent = false;
      enableAskPassword = false;
    };
  };

  services = {
    usbmuxd = {
      enable = true;
      package = pkgs.usbmuxd2;
    };
    flatpak.enable = true;
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    displayManager.sddm = {
      enable = true;
      package = pkgs.kdePackages.sddm;
      wayland.enable = true;
      theme = "catppuccin-mocha";
    };
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
    openssh = {
      sftpServerExecutable = "internal-sftp";
      enable = true;
      ports = [ 230 ];
      settings.PasswordAuthentication = true;
    };
    dbus.enable = true;
    xserver = {
      enable = true;
      displayManager.lightdm.enable = false;
      xrandrHeads = [{ output = "DP-2"; primary = true; }]; #Set Primary monitor on xwayland
      xkb = {
        variant = "";
        layout = "us";
      };
      excludePackages = with pkgs; [
        xterm
      ];
    };
    udev.packages = [ pkgs.yubikey-personalization ];
    hardware = {
      openrgb = {
        enable = true;
        package = pkgs.openrgb-with-all-plugins;
        motherboard = "amd";
      };
    };
  };

  xdg = {
    portal = {
      xdgOpenUsePortal = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-wlr
        pkgs.xdg-desktop-portal-gtk
      ];
      config.common.default = "*";
    };
    mime.defaultApplications = {
      "text/html" = "librewolf";
      "scheme-handler/http" = "librewolf";
      "scheme-handler/https" = "librewolf";
      "x-scheme-handler/http" = "librewolf";
      "x-scheme-handler/https" = "librewolf";
      "inode/directory" = "thunar";
    };
  };
  # Set your time zone./
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
  fonts = {
    packages = builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
    
    fontDir.enable = true;
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
    steam-hardware.enable = true;
  };

  nix = {
    gc = {
      dates = "weekly";
      automatic = true;
    };
    optimise = {
      automatic = true;
      dates = [
        "03:00"
      ];
    };
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
      cores = 10;
      max-jobs = 10;
      download-buffer-size = 524288000;
      #auto-optimize-store = true;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.bash;
    users.arkannon = {
      isNormalUser = true;
      description = "arkannon";
      extraGroups = [ "networkmanager" "wheel" "libvirtd" "kvm" "qemu-libvirtd" "dialout" "root" ];
      packages = [
      ];
    };
  };
  # $ nix search wget
  environment = {
    systemPackages = with pkgs; [
      wayneko
      pyprland
      hyprpaper
      catppuccin-sddm
      unzip
      wget
      mesa
      dxvk
      gparted
      neovim
      w3m
      dante
      inetutils
      sox
      eza
      git
      cowsay
      hugo
      gcc
      figlet
      mtr
      prettyping
      rustup
      curl
      zulu17
      libimobiledevice
      qogir-theme
      qogir-icon-theme
      virtiofsd
      clolcat
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
    etc = {
      "xdg/user-dirs.defaults".text = ''
        SCREENSHOT=Pictures/screenshots
      '';
    };
  };

  fileSystems."/vms" = {
    device = "/dev/disk/by-uuid/dd7864ff-40e8-4df3-8482-74828ce62690";
    fsType = "ext4";
    options = [
      "users"
      "nofail"
      "auto"
      "rw"
    ];
  };
  #fileSystems."/home/arkannon" = {
  #  device = "/dev/disk/by-uuid/2a2ce087-44f3-40c6-93d4-f7224e344c22";
  #  fsType = "ext4";
  #  options = [
  #    "users"
  #    "nofail"
  #    "auto"
  #    "exec"
  #   "rw"
  #  ];
  #};


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
  system.stateVersion = "24.05"; # Did you read the comment?

}

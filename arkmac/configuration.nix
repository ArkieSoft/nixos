{ pkgs, lib, ... }:
{
  users.users.arkannon.home = "/Users/arkannon";


  nixpkgs.config = {
    allowUnfree = true;
  };

  programs.bash.enable = true;

  nix.settings = {
    experimental-features = "nix-command flakes impure-derivations ca-derivations";
  };

  fonts = {
    packages = builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
  };


  homebrew = {
    enable = true;
    casks = [
      "chirp"
      "ukelele"
      "firefox"
      "signal"
      "nextcloud"
      "flameshot"
      "raspberry-pi-imager"
      "freecad"
    ];

    brews = [
      "sketchybar"
    ];
    taps = [
      "FelixKratz/formulae"
    ];
  };
  
  security.pam.services.sudo_local.touchIdAuth = true;
  
  system = {
    primaryUser = "arkannon";
    stateVersion = 5;
    defaults = {
      finder = {
        AppleShowAllFiles = true;
        AppleShowAllExtensions = true;
      };
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
      };
    };
  };
}

{ pkgs, ... }:
{
  users.users.arkannon.home = "/Users/arkannon";

  services = {
    nix-daemon.enable = true;
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  programs.bash.enable = true;

  nix.settings.experimental-features = "nix-command flakes impure-derivations ca-derivations";

  fonts.packages = [ pkgs.cascadia-code pkgs.nerdfonts ];

  homebrew = {
    enable = true;
    casks = [
      "firefox"
      "nextcloud"
      "parsec"
      "flameshot"
      "raspberry-pi-imager"
    ];
  };

  environment.loginShell = "/run/current-system/sw/bin/bash";

  security.pam.enableSudoTouchIdAuth = true;

  system = {
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

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
      "chirp"
      "ukelele"
      "firefox"
      "signal"
      "nextcloud"
      "parsec"
      "flameshot"
      "raspberry-pi-imager"
    ];
  };

  security.pam.enableSudoTouchIdAuth = true;

  system = {
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

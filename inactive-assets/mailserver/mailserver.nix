{ config, pkgs, ... }: {
  imports = [
    (builtins.fetchTarball {
      # Pick a release version you are interested in and set its hash, e.g.
      url = "https://gitlab.com/simple-nixos-mailserver/nixos-mailserver/-/archive/master/nixos-mailserver-master.tar.gz";
      # To get the sha256 of the nixos-mailserver tarball, we can use the nix-prefetch-url command:
      # release="nixos-23.05"; nix-prefetch-url "https://gitlab.com/simple-nixos-mailserver/nixos-mailserver/-/archive/${release}/nixos-mailserver-${release}.tar.gz" --unpack
      sha256 = "sha256:07lqrrc1pz7mawcgksrplb56bccfrnzwxrypj6qr6csh5nvf9k3b";
    })
  ];

  mailserver = {
    enable = true;
    fqdn = "mail.arkannon.com";
    domains = [ "arkannon.com" ];

    # nix-shell -p mkpasswd --run 'mkpasswd -sm bcrypt'
    loginAccounts = {
      "arkannon@arkannon.com" = {
        hashedPasswordFile = "/etc/nixos/mailserver/passwords/arkannon";
      };
      "wyatt@arkannon.com" = {
        hashedPasswordFile = "/etc/nixos/mailserver/passwords/wyatt";
      };
      "finances@arkannon.com" = {
        hashedPasswordFile = "/etc/nixos/mailserver/passwords/finances";
      };
      "social@arkannon.com" = {
        hashedPasswordFile = "/etc/nixos/mailserver/passwords/social";
      };
      "shopping@arkannon.com" = {
        hashedPasswordFile = "/etc/nixos/mailserver/passwords/shopping";
      };
    };

    certificateScheme = "acme-nginx";

    certificateDomains = [
      "mail.arkannon.com"
    ];
  };
  security.acme.acceptTerms = true;
  security.acme.defaults.email = "arkannon@arkannon.com";
}

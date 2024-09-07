{ pkgs, config, ... }:
{
  programs.fish = {
    enable = true;
    shellInitLast = ''
       set A $(shuf -i 1-5 -n 1)

      if test $A -eq 1
        neofetch
      else if test $A -eq 2
        neofetch --kitty ~/nix/fetchart/2b.png --size 15%
      else if test $A -eq 3
        neofetch --kitty ~/nix/fetchart/2b2.jpg --size 15%
      else if test $A -eq 4
        neofetch --ascii ~/nix/fetchart/kisser
      else
        neofetch --ascii ~/nix/fetchart/Pentag
      end
    '';

    shellAliases = {
      mailserver = "ssh wyatt@mail.arkannon.com";
      cloudserver = "ssh wyatt@arkannon.com";
      nixconfig = "cd /etc/nixos and git pull and nvim";
      cls = "clear";
      sl = "ls";
      grep = "grep --color=auto";
      vmstart = "LIBVIRT_DEFAULT_URI=qemu:///system virsh start";
      vmstop = "LIBVIRT_DEFAULT_URI=qemu:///system virsh stop";
      v = "nvim";
      cd = "z";
      pgrep = "pgrep -fl";
      pkill = "pkill -f";
      ping = "prettyping";
      wttr = "curl wttr.in/Port+Orchard?m";
    };
  };
} 

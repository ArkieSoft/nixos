{ pkgs, ... }:
{
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      alias orphanstomper='sudo nix store gc && sudo nix-collect-garbage'
      alias elderlystomper='sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations old'
      alias cls='clear'
      alias grep='grep --color=auto'
      alias nixconfig='cd /etc/nixos && nvim'
      alias updoot='cd /etc/nixos && sudo nix flake update && sudo nixos-rebuild switch'
      alias switch='cd /etc/nixos && sudo nixos-rebuild switch'
      alias v='nvim'
    '';
  };
}

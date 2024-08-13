{ pkgs, ... }:
{
  programs.bash =
    {
      enable = true;
      bashrcExtra = ''

        A=$(shuf -i 1-6 -n 1)

        if [ $A -eq 1 ]; then
          neofetch
        elif [ $A -eq 2 ]; then
          neofetch --kitty /etc/nixos/fetchart/2b.png --size 15%
        elif [ $A -eq 3 ]; then
          neofetch --kitty /etc/nixos/fetchart/2b2.jpg --size 15%
        elif [ $A -eq 4 ]; then 
          neofetch --ascii /etc/nixos/fetchart/kisser
        elif [ $A -eq 5 ]; then
          neofetch --kitty /etc/nixos/fetchart/boobies.jpg --size 30%
        else
          neofetch --ascii /etc/nixos/fetchart/Pentag
        fi

        [[ $- != *i* ]] && return


        eval "$(oh-my-posh init bash --config /etc/nixos/assets/M365Princess.omp.json)"


        ### OS MANAGEMENT ###
        alias passwds='nvim /home/arkannon/Documents/passwords'
        alias orphanstomper='sudo nix store gc && sudo nix-collect-garbage && cowsay -f hellokitty \"Orphans Successfully Stomped\" | lolcat'
        alias elderlystomper='sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations old && cowsay -f stegosaurus \"No Elders Left to Stomp, Now!\" | lolcat'
        alias taxcuts='sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations old && cowsay -f stegosaurus \"Medicare Successfully Cut!\" | lolcat && echo \"Starving Orphans, We Will Be Right Back!\" | lolcat && sudo nix store gc && sudo nix-collect-garbage && cowsay -f hellokitty \"WIC Successfully cut!\" | lolcat'
        alias mailserver='ssh wyatt@mail.arkannon.com'
        alias cloudserver='ssh wyatt@arkannon.com'
        alias updoot='cd /etc/nixos/ && git add . && sudo nix flake update && sudo nixos-rebuild switch && echo "updating channels for manix" && nix-channel --update && cowsay -f sodomized updooted | lolcat'
        alias switch='cd /etc/nixos/ && git add . && sudo nixos-rebuild switch && cowsay -f sodomized switched | lolcat'
        
        ### MEMES ###
        alias brb='bash /etc/nixos/scripts/brb.sh'
        alias tbc='bash /etc/nixos/scripts/tbc.sh'
        alias dance='bash /etc/nixos/scripts/dance.sh'
        
        alias nixconfig='cd /etc/nixos && nvim'
        alias cls='clear'
        alias matrix='gomuks'
        alias sl='eza --color always --icons';
        alias ls='eza --color always --icons';
        alias grep='grep --color=auto'
        alias size='du -cha --max-depth=1 . | grep -E \"M|G\"'
        alias vmstart='LIBVIRT_DEFAULT_URI=qemu:///system virsh start WindowsVM'
        alias vmstop='LIBVIRT_DEFAULT_URI=qemu:///system virsh shutdown WindowsVM'
        alias v='nvim'
        alias cd='z'
        alias ping='prettyping'
        alias plz='sudo'
        alias ga.='git add .'
        alias gc='git commit -m'
        alias gp='git push'
        alias gl='git log'
        alias wttr='curl wttr.in/Port+Orchard?m'

        PS1='[\u@\h \W]\$ '



        '';


    };
}

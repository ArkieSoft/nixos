{ pkgs, lib, config, ... }:
{
  programs.bash = {
    enable = true;
    bashrcExtra = ''

        A=$(shuf -i 1-5 -n 1)

        if [ $A -eq 1 ]; then
          neofetch
        elif [ $A -eq 2 ]; then
          neofetch --kitty ~/nix/fetchart/2b.png --size 15%
        elif [ $A -eq 3 ]; then
          neofetch --kitty ~/nix/fetchart/2b2.jpg --size 15%
        elif [ $A -eq 4 ]; then 
          neofetch --ascii ~/nix/fetchart/kisser
        else
          neofetch --ascii ~/nix/fetchart/Pentag
        fi

        [[ $- != *i* ]] && return
        
        export PATH=$PATH:~/.cargo/bin/

        eval "$(oh-my-posh init bash --config ~/nix/assets/M365Princess.omp.json)"


        ### OS MANAGEMENT ###
        alias orphanstomper='sudo nix store gc && sudo nix-collect-garbage && cowsay -f hellokitty \"Orphans Successfully Stomped\" | lolcat'
        alias elderlystomper='sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations old && cowsay -f stegosaurus \"No Elders Left to Stomp, Now!\" | lolcat'
        alias taxcuts='sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations old && cowsay -f stegosaurus \"Medicare Successfully Cut!\" | lolcat && echo \"Starving Orphans, We Will Be Right Back!\" | lolcat && sudo nix store gc && sudo nix-collect-garbage && cowsay -f hellokitty \"WIC Successfully cut!\" | lolcat'
        alias mailserver='ssh -i ~/.ssh/mailserver wyatt@mail.arkannon.com'
        alias cloudserver='ssh -i ~/.ssh/cloudserver wyatt@arkannon.com'

        alias pythonenv='nix-shell /etc/nixos/nix-shell/python.nix'
        alias nixconfig='cd /etc/nixos && git pull && nvim'
        alias cls='clear'
        alias matrix='gomuks'
        alias sl='eza --color always --icons';
        alias ls='eza --color always --icons';
        alias grep='grep --color=auto'
        alias size='du -cha --max-depth=1 . | grep -E "M|G"'
        alias vmstart='LIBVIRT_DEFAULT_URI=qemu:///system virsh net-start default && LIBVIRT_DEFAULT_URI=qemu:///system virsh start WindowsVM'
        alias vmstop='LIBVIRT_DEFAULT_URI=qemu:///system virsh shutdown WindowsVM'
        alias v='nvim'
        alias cd='z'
        alias pgrep='pgrep -fl'
        alias pkill='pkill -f'
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

{
  enable = true;
  bashrcExtra = "



[[ $- != *i* ]] && return

neofetch --ascii /etc/nixos/Pentag

eval \"$(oh-my-posh init bash --config /etc/nixos/M365Princess.omp.json)\"

alias passwds='nvim /home/arkannon/Documents/passwords'\n
#alias pac='pacseek'\n
#alias orphanstomper='yay -Qtdq | yay -Rns -'\n
alias updoot='sudo zypper update'\n
alias arkiemail.com='ssh root@arkiemail.com'\n
alias arkannon.com='ssh wyatt@arkannon.com'\n
alias sl='ls'\n
alias grep='grep --color=auto'\n
alias size='du -cha --max-depth=1 . | grep -E \"M|G\"'\n
alias nixconfig='sudo nvim /etc/nixos/configuration.nix'\n
alias switch='sudo nixos-rebuild switch'\n
PS1='[\u@\h \W]\$ '\n

export VISUAL=nvim

export PATH=\"/usr/sbin/:$PATH\"
export PATH=\"/bin/systemctl/:$PATH\"
";


}

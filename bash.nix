{
  enable = true;
  bashrcExtra = "



[[ $- != *i* ]] && return

neofetch --ascii /etc/nixos/Pentag

eval \"$(oh-my-posh init bash --config /etc/nixos/M365Princess.omp.json)\"

alias passwds='nvim /home/arkannon/Documents/passwords'
#alias pac='pacseek'
alias orphanstomper='nix store gc'
#alias updoot='sudo zyppe
alias arkiemail.com='ssh root@arkiemail.com'
alias arkannon.com='ssh wyatt@arkannon.com'
alias sl='ls'
alias grep='grep --color=auto'
alias size='du -cha --max-depth=1 . | grep -E \"M|G\"'
alias nixconfig='cd /etc/nixos && nvim'
alias switch='cd /etc/nixos/ && git add . && sudo nixos-rebuild switch'
PS1='[\u@\h \W]\$ '

export VISUAL=nvim

export PATH=\"/usr/sbin/:$PATH\"
export PATH=\"/bin/systemctl/:$PATH\"
";


}

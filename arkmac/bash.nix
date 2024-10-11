{ pkgs, ... }:
{
  programs.bash = {
    enable = true;
    bashrcExtra = "
export PATH=/opt/homebrew/bin:$PATH
neofetch
eval \"$(oh-my-posh init bash --config ~/nix/assets/M365Princess.omp.json)\"

export BASH_SILENCE_DEPRECATION_WARNING=1

alias cd='z'
alias nixconfig='cd ~/.config/nixos && git add . && nvim'
alias v='nvim'
alias elderlystomper='sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations old && cowsay -f stegosaurus \"No Elders Left to Stomp, Now!\" | lolcat'

alias orphanstomper='nix store gc && nix-collect-garbage && cowsay -f hellokitty \"Orphans Successfully Stomped\" | lolcat'
alias mailserver='ssh wyatt@mail.arkannon.com'
alias cloudserver='ssh -i ~/.ssh/cloudserver wyatt@arkannon.com'
alias arkdesk='ssh -p 230 arkannon@arkannon.com'
alias sl='eza --color always --icons'
alias grep='grep --color=auto'
alias cls='clear'
alias ls='eza --color always --icons'
alias grep='grep --color=auto'
alias wttr='curl wttr.in/Port+Orchard?m'

";
  };
}

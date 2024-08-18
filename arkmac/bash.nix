{ pkgs, ... }:
{
  programs.bash = {
    enable = true;
    bashrcExtra = "
neofetch
eval \"$(oh-my-posh init bash --config ~/.config/nixos/assets/M365Princess.omp.json)\"

export BASH_SILENCE_DEPRECATION_WARNING=1

alias cd='z'
alias updoot='cd ~/.config/nixos && git add . && nix flake update . && darwin-rebuild switch --flake .'
alias switch='bash /Users/arkannon/.config/nixos/scripts/switch.sh mac'
alias nixconfig='cd ~/.config/nixos && git add . && nvim'
alias v='nvim'
alias elderlystomper='sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations old && cowsay -f stegosaurus \"No Elders Left to Stomp, Now!\" | lolcat'
 
alias nixgit='bash /Users/arkannon/.config/scripts/gupdate.sh'

alias orphanstomper='nix store gc && nix-collect-garbage && cowsay -f hellokitty \"Orphans Successfully Stomped\" | lolcat'
alias mailserver='ssh wyatt@mail.arkannon.com'
alias homeserver='ssh wyatt@arkannon.com'
alias arkdesk='ssh -p 230 arkannon@arkannon.com'
alias sl='eza --color always --icons'
alias grep='grep --color=auto'
alias cls='clear'
alias ls='eza --color always --icons'
alias grep='grep --color=auto'
alias wttr='curl wttr.in/Port+Orchard?m'

### MEMES ###


if [ -z \"$__NIX_DARWIN_SET_ENVIRONMENT_DONE\" ]; then
  . /nix/store/lr100jhkyg6sdbj46ymyrp4qr8dj414l-set-environment
fi

[[ $- != *i* ]] && return
";
  };
}

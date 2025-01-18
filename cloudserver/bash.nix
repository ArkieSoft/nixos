{ pkgs, lib, config, ... }:
{
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      [[ $- != *i* ]] && return

      ### OS MANAGEMENT ###
      alias nixconfig='cd /etc/nixos && git pull && nvim'
      alias cls='clear'
      alias sl='eza --color always --icons';
      alias ls='eza --color always --icons';
      alias grep='grep --color=auto'
      alias size='du -cha --max-depth=1 . | grep -E "M|G"'
      alias v='nvim'
      alias cd='z'
      alias pgrep='pgrep -fl'
      alias pkill='pkill -f'
      alias ga.='git add .'
      alias gc='git commit -m'
      alias gp='git push'
      alias gl='git log'

      PS1='[\u@\h \W]\$ '
    '';
  };
}

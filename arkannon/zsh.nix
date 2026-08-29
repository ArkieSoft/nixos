{ pkgs, lib, config, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    
    envExtra = ''
      A=$(shuf -i 1-5 -n 1)

      if [ $A -eq 1 ]; then
        fastfetch
      elif [ $A -eq 2 ]; then
        fastfetch -c /etc/nixos/fetchart/fetchconfigs/2b.jsonc
      elif [ $A -eq 3 ]; then
        fastfetch -c /etc/nixos/fetchart/fetchconfigs/2b2.jsonc
      elif [ $A -eq 4 ]; then 
        fastfetch -c /etc/nixos/fetchart/fetchconfigs/kisser.jsonc
      else
        fastfetch -c /etc/nixos/fetchart/fetchconfigs/Pentag.jsonc
      fi
      
      nls() {
        if (( $+commands[nu] )); then
          # Join all Zsh arguments with spaces into a clean string
          local args="''${*:-}"
        
          # Execute Nushell, passing the arguments inside the ls string
          nu -l -c "ls $args"
        else
          echo "Error: Nushell (nu) is not installed on your system."
          command ls "$@"
        fi
      }
      
      wttr() {
        nu -l -c "curl wttr.in/Port+Orchard?m"
      }

      cdls() {
        z "$@"
        nls .
      }

      eval "$(pay-respects zsh)"

     
      [[ $- != *i* ]] && return
      
      export PATH=$PATH:~/.cargo/bin/

      ### OS MANAGEMENT ###
      alias orphanstomper='sudo nix store gc && sudo nix-collect-garbage && cowsay -f hellokitty \"Orphans Successfully Stomped\" | lolcat'
      alias elderlystomper='sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations old && cowsay -f stegosaurus \"No Elders Left to Stomp, Now!\" | lolcat'
      alias taxcuts='sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations old && cowsay -f stegosaurus \"Medicare Successfully Cut!\" | lolcat && echo \"Starving Orphans, We Will Be Right Back!\" | lolcat && sudo nix store gc && sudo nix-collect-garbage && cowsay -f hellokitty \"WIC Successfully cut!\" | lolcat'
      alias mailserver='ssh -i ~/.ssh/mailserver wyatt@mail.arkannon.com'
      alias cloudserver='ssh -i ~/.ssh/id_ed25519 wyatt@arkannon.com'
      alias arkmac='ssh arkannon@192.168.4.209'
      alias edclear='protontricks -c "wineserver -k" 359320'

      alias pythonenv='nix-shell /etc/nixos/nix-shell/python.nix'
      alias nixconfig='cd /etc/nixos && git pull && nvim'
      alias cls='clear'
      alias matrix='gomuks'
      alias sl='eza --color always --icons';
      alias ls='nls';
      alias grep='grep --color=auto'
      alias size='du -cha --max-depth=1 . | grep -E "M|G"'
      alias vmstart='LIBVIRT_DEFAULT_URI=qemu:///system virsh net-start default && LIBVIRT_DEFAULT_URI=qemu:///system virsh start WindowsVM'
      alias vmstop='LIBVIRT_DEFAULT_URI=qemu:///system virsh shutdown WindowsVM'
      alias v='nvim'
      alias cd='cdls'
      alias pgrep='pgrep -fl'
      alias pkill='pkill -f'
      alias ping='prettyping'
      alias plz='sudo'
      alias ga.='git add .'
      alias gc='git commit -m'
      alias gp='git push'
      alias gl='git log'
      alias wttr='wttr'
      alias snake='nix-shell /etc/nixos/shells/python.nix'

      PS1='[\u@\h \W]\$ '
    '';

    plugins = [
      {
        name = "zsh-autocomplete";
        src = pkgs.fetchFromGitHub {
          owner = "marlonrichert";
          repo = "zsh-autocomplete";
          rev = "25.03.19";
          sha256 = "sha256-eb5a5WMQi8arZRZDt4aX1IV+ik6Iee3OxNMCiMnjIx4=";
        };
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.8.0";
          sha256 = "sha256-iJdWopZwHpSyYl5/FQXEW7gl/SrKaYDEtTH9cGP7iPo=";
        };
      }
      {
        name = "zsh-history-substring-search";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-history-substring-search";
          rev = "v1.1.0";
          sha256 = "sha256-GSEvgvgWi1rrsgikTzDXokHTROoyPRlU0FVpAoEmXG4=";
        };
      }
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.1";
          sha256 = "sha256-vpTyYq9ZgfgdDsWzjxVAE7FZH4MALMNZIFyEOBLm5Qo=";
        };
      }
      {
        name = "nix-zsh-completion";
        src = pkgs.fetchFromGitHub {
          owner = "nix-community";
          repo = "nix-zsh-completions";
          rev = "0.5.1";
          sha256 = "sha256-bgbMc4HqigqgdkvUe/CWbUclwxpl17ESLzCIP8Sz+F8=";
        };
      }
      {
        name = "zsh-help";
        src = pkgs.fetchFromGitHub {
          owner = "Freed-Wu";
          repo = "zsh-help";
          rev = "95cbc11";
          sha256 = "sha256-ij+ooXQxV3CmsCN/CrJMicTWvS+9GYHA/1Kuqh5zXIY=";
        };
      }
      {
        name = "usb.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "NiziL";
          repo = "usb.plugin.zsh";
          rev = "562a98a";
          sha256 = "sha256-ADgz/kqD9RN5HS373MfXc3CHV/jEyptolCwAeGT9Sb4=";
        };
      }
      {
        name = "pass-zsh-completion";
        src = pkgs.fetchFromGitHub {
          owner = "ninrod";
          repo = "pass-zsh-completion";
          rev = "e4d8d2c";
          sha256 = "sha256-KfZJ9XxZ8cBePcJPOAPQZ+f5kVUgLExDw/5QSduDA/0=";
        };
      }
      {
        name = "zsh-kitty";
        src = pkgs.fetchFromGitHub {
          owner = "redxtech";
          repo = "zsh-kitty";
          rev = "8ea9f1d";
          sha256 = "sha256-SdZe6BPXgVuuJo4wolSLRaIGtkO3g8dlsGbnZkPfJ4U=";
        };
      }
      {
        name = "you-should-use";
        src = pkgs.fetchFromGitHub {
          owner = "MichaelAquilina";
          repo = "zsh-you-should-use";
          rev = "1.11.1";
          sha256 = "sha256-a/DNVxD55Bh6AmSh5C4z4JpZM5xUiQgoaFoDgYPQsbo=";
        };
      }
      {
        name = "zsh-bat";
        src = pkgs.fetchFromGitHub {
          owner = "fdellwing";
          repo = "zsh-bat";
          rev = "4673376";
          sha256 = "sha256-TTuYZpev0xJPLgbhK5gWUeGut0h7Gi3b+e00SzFvSGo=";
        };
      }
      {
        name = "zwordle";
        src = pkgs.fetchFromGitHub {
          owner = "yertto";
          repo = "zwordle";
          rev = "201c3d5";
          sha256 = "sha256-7qZum7oU4VIsQxWty0Mtz/yFhvvIH45ctCWaeYH1XjE=";
        };
      }
      {
        name = "flatpak-zsh-completion";
        src = pkgs.fetchFromGitHub {
          owner = "bilelmoussaoui";
          repo = "flatpak-zsh-completion";
          rev = "83ba8f1";
          sha256 = "sha256-a31Bfzjf9TYO7entScJy/87VmWNpZdT6iml3uLJ3UTc=";
        };
      }
    ];
  };
}

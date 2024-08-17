#!/run/current-system/sw/bin/bash

macpath="/Users/arkannon/.config/nixos"
nixpath="/etc/nixos"

if [[ $1 = "mac" ]] || [[ $1 = "Mac" ]];then
  cd $macpath
  system="mac"
elif [[ $1 = "Nixos" ]] || [[ $1 = "nixos" ]];then
  cd $nixpath
  system="nix"
else 
  echo "NixOS (1) or Mac (2)?: "
  read choice
  if [[ $choice = 1 ]];then
    cd $nixpath
    system="nix"
  elif [[ $choice = 2 ]];then
    cd $macpath
    system="mac"
  else
    echo "You're not taking this seriously are you?"
    exit
  fi
fi

git add .

if [[ $system = "nix" ]]; then
  sudo nixos-rebuild switch
  cowsay -f sodomized switched | lolcat
elif [[ $system = "mac" ]]; then
  darwin-rebuild switch --flake .
  cowsay -f sodomized switched | lolcat
else
  echo "Something went horribly wrong, figure it out!"
fi

echo "Do you want to make a commit? [y/N]: "
read git

if [[ $git = y ]] || [[ $git = Y ]];then
  echo "What to label for commit?: "
  read commit
  git commit -m "$commit"
else
  figlet "Switch Completed" | lolcat
  exit
fi

echo "Do you want to push the commit? [y/N]: "
read push

if [[ $push = "y" ]] || [[ $push = "Y" ]]; then
  git push
  figlet "Switch, Commit, and Push Completed" | lolcat
  exit
else
  figlet "Switch, and Commit Completed" | lolcat
  exit
fi
exit


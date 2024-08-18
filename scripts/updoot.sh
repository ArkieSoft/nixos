#!/run/current-system/sw/bin/bash

macpath="$HOME/.config/nixos"
nixpath="/etc/nixos"

if [[ $1 = "mac" ]] || [[ $1 = "Mac" ]];then
  cd $macpath
  system="mac"
elif [[ $1 = "Nix" ]] || [[ $1 = "nix" ]];then
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
  sudo nix flake update
  sudo nixos-rebuild boot
elif [[ $system = "mac" ]]; then
  darwin-rebuild switch  --flake .
else
  echo "Something went horribly wrong, figure it out!"
fi

cowsay -f sodomized Updooted | lolcat
echo "Updating Channels for Manix"
nix-channel --update
echo "Do you want to make a commit? [y/N]: "
read git

if [[ $git = y ]] || [[ $git = Y ]];then
  echo "What to label for commit?: "
  read commit
  git commit -m "$commit"
else
  figlet "Updoot Completed" | lolcat
  exit
fi

echo "Do you want to push the commit? [y/N]: "
read push

if [[ $push = "y" ]] || [[ $push = "Y" ]]; then
  git push
  figlet "Update, Commit, and Push Completed" | lolcat
  exit
else
  figlet "Update, and Commit Completed" | lolcat
  exit
fi
exit


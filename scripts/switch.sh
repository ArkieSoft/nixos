#!/usr/bin/env bash

platform="$(uname)"

function darwin() {
  cd $HOME/.config/nixos
  git add .
  darwin-rebuild switch --flake .
  main
}

function linux_mod() {
  cd /etc/nixos/
  git add .
  nixos-rebuild --use-remote-sudo switch
  main
}

function main(){ 
  cowsay -f sodomized switched | lolcat
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
}

case $platform in
  "Darwin")
    darwin
    ;;
  "Linux")
    linux_mod
    ;;
  *)
    echo "Splish Sp'd'own, your PC is unkown"
    exit 1
esac


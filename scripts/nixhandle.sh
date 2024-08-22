#!/usr/bin/env bash

platform="$(uname)"

switch() {
  git add .
  case $os in
    m)
      darwin-rebuild switch --flake .
      figlet "Switched"
      nixgit
      ;;
    n)
      nixos-rebuild --use-remote-sudo switch
      figlet "Switched"
      nixgit
      ;;
    l)
      echo "Work in Progress"
      exit 1
      ;;
    *)
      echo "uhhh...."
      exit 1
      ;;
  esac
}

update() {
  git add .
  case $os in
    m)
      nix flake udpate .
      figlet "Updooted"
      nixgit
      ;;
    n)
      sudo nix flake update
      nixos-rebuild --use-remote-sudo boot
      figlet "Updooted"
      nixgit

      ;;
    l)
      echo "Work in Progress"
      exit 1
      ;;
    *)
      echo "uhhhh....."
      exit 1
      ;;
  esac
}

nixgit() {
  echo "Do you want to make a commit? [y/N]: "
  read git

  if [[ $git = y ]] || [[ $git = Y ]];then
    echo "What to label for commit?: "
    read commit
    git commit -m "$commit"
  else
    case $1 in
      g | git)
        figlet "This was an exercise in futility" | lolcat
        exit 1
        ;;
      u | update)
        figlet "Updoot Complete" | lolcat
        exit 1
        ;;
      s | switch)
        figlet "Switch Complete" | lolcat
        exit 1
        ;;
      *)
        echo "uhhhhhh"
        exit 1
        ;;
    esac
  fi

  echo "Do you want to push the commit? [y/N]: "
  read push

  if [[ $push == y ]] || [[ $push == Y ]];then
    git push
    figlet "Commit Pushed"
    exit 1
  else
    case $1 in
      g | git)
        figlet "Commit Made"
        exit 1
        ;;
      u | update)
        figlet "Updated"
        exit 1
        ;;
      s | switch)
        figlet "Switched"
        exit 1
        ;;
      *)
        echo "uhhhh"
        exit 1
        ;;
    esac
  fi
    exit 1
}

case $platform in
  Darwin)
    cd $HOME/.config/nixos
    os="m"
    ;;
  Linux)
    source /etc/os-release
    if [[ $ID == nixos ]]; then
      cd /etc/nixos
      os="n"
    else
      cd $HOME/.config/nixos
      os="l"
    fi
    ;;
  *)
    echo "Wtf are you doing?"
    exit 1
    ;;
esac

case $1 in
  g | git)
    nixgit
    ;;
  u | update)
    update
    ;;
  s | switch)
    switch
    ;;
  *)
    echo "No arguments, provided! g for Git, u for Update, s for Switch"
    exit 1
esac


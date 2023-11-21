#!/usr/bin/env bash
# Make hard links of the dotfiles

# Install utilities for remote environments
if command -v apt-get; then
  # Eza
  sudo apt-get update -y
  sudo apt-get install -y gpg
  sudo mkdir -p /etc/apt/keyrings
  wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
  echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
  sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
  sudo apt-get update -y
  sudo apt-get install -y eza

  # Ripgrep
  curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
  sudo dpkg -i ripgrep_13.0.0_amd64.deb
fi

if test ! -d $HOME/.config/fish; then
  mkdir -p $HOME/.config/fish
fi
if test ! -d $HOME/.config/fish/functions; then
  mkdir -p $HOME/.config/fish/functions
fi

if test $(uname) = Darwin; then
  ln -vf .gitignore .gitconfig .vimrc .npmrc $HOME
  ln -vf fish/*.fish $HOME/.config/fish
  ln -vf fish/functions/*.fish $HOME/.config/fish/functions

  if test ! -d $HOME/Library/Application\ Support/iTerm2/Scripts/AutoLaunch; then
    mkdir -p $HOME/Library/Application\ Support/iTerm2/Scripts/AutoLaunch
  fi
  if test ! -d $HOME/Library/Application\ Support/Code/User; then
    mkdir -p $HOME/Library/Application\ Support/Code/User
  fi
  # if test ! -d $HOME/Library/Application\ Support/Code/User/snippets; then
  #   mkdir -p $HOME/Library/Application\ Support/Code/User/snippets
  # fi

  ln -vf iterm/dark-mode.py $HOME/Library/Application\ Support/iTerm2/Scripts/AutoLaunch
  ln -vf vscode/*.json $HOME/Library/Application\ Support/Code/User
  # ln -vf vscode/snippets/*.json $HOME/Library/Application\ Support/Code/User/snippets
else
  cp .gitignore .gitconfig .vimrc .npmrc $HOME
  cp fish/*.fish $HOME/.config/fish
  cp fish/functions/*.fish $HOME/.config/fish/functions
fi

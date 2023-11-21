#!/usr/bin/env bash
# Make hard links of the dotfiles

# Install utilities for remote environments
if command -v apt-get; then
  apt-get -y update && apt-get -y install exa ripgrep
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
  if test ! -d $HOME/Library/Application\ Support/Code/User/snippets; then
    mkdir -p $HOME/Library/Application\ Support/Code/User/snippets
  fi

  ln -vf iterm/dark-mode.py $HOME/Library/Application\ Support/iTerm2/Scripts/AutoLaunch
  ln -vf vscode/*.json $HOME/Library/Application\ Support/Code/User
  ln -vf vscode/snippets/*.json $HOME/Library/Application\ Support/Code/User/snippets
else
  cp .gitignore .gitconfig .vimrc .npmrc $HOME
  cp fish/*.fish $HOME/.config/fish
  cp fish/functions/*.fish $HOME/.config/fish/functions
fi

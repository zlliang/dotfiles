#!/usr/bin/env bash
# Make hard links of the dotfiles

if test ! -d $HOME/.config/fish; then
  mkdir -p $HOME/.config/fish
fi
if test ! -d $HOME/.config/fish/functions; then
  mkdir -p $HOME/.config/fish/functions
fi

if test $(uname) = Darwin; then
  ln -vf .gitignore .gitconfig .npmrc .hushlogin $HOME
  ln -vf fish/*.fish $HOME/.config/fish
  ln -vf fish/functions/*.fish $HOME/.config/fish/functions

  if test ! -d $HOME/Library/Application\ Support/iTerm2/Scripts/AutoLaunch; then
    mkdir -p $HOME/Library/Application\ Support/iTerm2/Scripts/AutoLaunch
  fi

  ln -vf iterm/dark-mode.py $HOME/Library/Application\ Support/iTerm2/Scripts/AutoLaunch
else
  cp .gitignore .gitconfig .npmrc $HOME
  cp fish/*.fish $HOME/.config/fish
  cp fish/functions/*.fish $HOME/.config/fish/functions
fi

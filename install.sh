#!/usr/bin/env bash
# Apply the dotfiles

cp .hushlogin .gitignore .gitconfig .npmrc .vimrc $HOME

mkdir -p $HOME/.config/fish
mkdir -p $HOME/.config/fish/functions
cp .config/fish/*.fish $HOME/.config/fish
cp .config/fish/functions/*.fish $HOME/.config/fish/functions

mkdir -p $HOME/.config/ghostty
cp .config/ghostty/config $HOME/.config/ghostty

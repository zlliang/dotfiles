#!/usr/bin/env bash
# Copy the dotfiles

mkdir -p $HOME/.config/fish
mkdir -p $HOME/.config/fish/functions

cp .hushlogin .gitignore .gitconfig .npmrc .vimrc $HOME
cp fish/*.fish $HOME/.config/fish
cp fish/functions/*.fish $HOME/.config/fish/functions

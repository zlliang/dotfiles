#!/usr/bin/env bash
# Make hard links of the dotfiles

if test ! -d ~/.config/fish; then
  mkdir -p ~/.config/fish
fi
if test ! -d ~/.config/fish/functions; then
  mkdir -p ~/.config/fish/functions
fi
if test ! -d ~/.config/pip; then
  mkdir -p ~/.config/pip
fi
if test ! -d ~/Library/Application\ Support/Code/User; then
  mkdir -p ~/Library/Application\ Support/Code/User
fi
if test ! -d ~/Library/Application\ Support/Code/User/snippets; then
  mkdir -p ~/Library/Application\ Support/Code/User/snippets
fi

ln -vf .gitignore .gitconfig .vimrc ~
ln -vf fish/config.fish ~/.config/fish
ln -vf fish/functions/*.fish ~/.config/fish/functions
ln -vf pip/pip.conf ~/.config/pip
ln -vf vscode/*.json ~/Library/Application\ Support/Code/User
ln -vf vscode/snippets/*.json ~/Library/Application\ Support/Code/User/snippets

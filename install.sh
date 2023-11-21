#!/usr/bin/env bash
# Make hard links of the dotfiles

# Install utilities for remote environments
if command -q apt-get
  apt-get -y update && apt-get -y install exa ripgrep
end

if test ! -d $HOME/.config/fish
  mkdir -p $HOME/.config/fish
fi
if test ! -d $HOME/.config/fish/functions
  mkdir -p $HOME/.config/fish/functions
fi

ln -vf .gitignore .gitconfig .vimrc .npmrc $HOME
ln -vf fish/*.fish $HOME/.config/fish
ln -vf fish/functions/*.fish $HOME/.config/fish/functions

if test (uname) = Darwin
  if test ! -d $HOME/Library/Application\ Support/iTerm2/Scripts/AutoLaunch
    mkdir -p $HOME/Library/Application\ Support/iTerm2/Scripts/AutoLaunch
  fi
  if test ! -d $HOME/Library/Application\ Support/Code/User
    mkdir -p $HOME/Library/Application\ Support/Code/User
  fi
  if test ! -d $HOME/Library/Application\ Support/Code/User/snippets
    mkdir -p $HOME/Library/Application\ Support/Code/User/snippets
  fi

  ln -vf iterm/dark-mode.py $HOME/Library/Application\ Support/iTerm2/Scripts/AutoLaunch
  ln -vf vscode/*.json $HOME/Library/Application\ Support/Code/User
  ln -vf vscode/snippets/*.json $HOME/Library/Application\ Support/Code/User/snippets
fi

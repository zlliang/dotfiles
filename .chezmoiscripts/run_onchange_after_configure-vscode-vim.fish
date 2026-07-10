#!/usr/bin/env fish

source "$HOME/.config/fish/config.fish"

# Enable key-repeating for VS Code Vim plugin.
# See https://marketplace.visualstudio.com/items?itemName=vscodevim.vim.
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

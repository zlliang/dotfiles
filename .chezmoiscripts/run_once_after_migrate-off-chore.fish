#!/usr/bin/env fish

if type -q chore
  rm -rf ~/.homebrew
  brew remove chore
  brew untap zlliang/tap

  rm -rf ~/.config/chore
end

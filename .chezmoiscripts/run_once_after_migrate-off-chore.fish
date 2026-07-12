#!/usr/bin/env fish

if type -q chore
  rm -rf ~/.homebrew
  brew remove chore
  brew untap zlliang/tap
end

rm -rf ~/.config/chore

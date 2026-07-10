#!/usr/bin/env fish

source "$HOME/.config/fish/config.fish"

function install_missing_brew_packages
  set -l installed_packages (brew list --versions --json | jq -r '.formulae[].name, .casks[].token')
  set -l missing_packages

  for package in $argv
    if not contains -- (path basename "$package") $installed_packages
      set -a missing_packages "$package"
    end
  end

  if test (count $missing_packages) -gt 0
    brew install $missing_packages
  end
end

install_missing_brew_packages \
  nodenv \
  uv \
  bat \
  eza \
  fd \
  ripgrep \
  zoxide \
  fastfetch \
  hyperfine \
  chezmoi \
  mole \
  ffmpeg \
  zlliang/tap/chore \
  ghostty \
  keka \
  orbstack \
  thaw
or exit

if not type -q bun
  curl -fsSL https://bun.com/install | bash
  or exit
  fish_add_path -g "$HOME/.bun/bin"
end

if not type -q rustup
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
  or exit
end

if not type -q amp
  curl -fsSL https://ampcode.com/install.sh | bash
  or exit
end

if not type -q pi
  bun add -g --ignore-scripts @earendil-works/pi-coding-agent
  or exit
end

setup-global-agent-skills

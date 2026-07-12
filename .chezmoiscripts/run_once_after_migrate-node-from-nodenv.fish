#!/usr/bin/env fish

source "$HOME/.config/fish/config.fish"

set -l node_version
if type -q nodenv
  set node_version (nodenv version-name 2>/dev/null)
end

if test -n "$node_version"; and test "$node_version" != system
  echo "Migrating Node.js $node_version from nodenv to fnm..."
  fnm install --use "$node_version"
else
  echo "Installing the latest LTS Node.js via fnm..."
  fnm install --lts --use
  set node_version (fnm current | string replace -r '^v' '')
end
or exit

fnm default "$node_version"
or exit

if type -q corepack
  echo "Updating pnpm..."
  corepack prepare pnpm@latest --activate
  or exit
end

if type -q brew
  for formula in nodenv node-build
    if brew list --formula "$formula" >/dev/null 2>&1
      brew uninstall "$formula"
      or exit
    end
  end
  brew cleanup nodenv node-build
end

set -l nodenv_roots "$HOME/.nodenv"
if set -q NODENV_ROOT; and not contains -- "$NODENV_ROOT" $nodenv_roots
  set -a nodenv_roots "$NODENV_ROOT"
end
rm -rf -- $nodenv_roots

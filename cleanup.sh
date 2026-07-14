#!/usr/bin/env bash

set -euo pipefail

paths=(
  "$HOME/.config/fish/conf.d"
  "$HOME/.config/fish/completions/chezmoi.fish"
  "$HOME/.local/share/fish/vendor_completions.d/chezmoi.fish"
  "$HOME/.cache/chezmoi"
  "$HOME/.config/chezmoi"
  "$HOME/.local/share/chezmoi"
  "$HOME/.local/state/chezmoi"
  "$HOME/Library/Caches/chezmoi"
  "$HOME/.local/bin/chezmoi"
  "$HOME/.local/share/mise/downloads/chezmoi"
  "$HOME/.local/share/mise/installs/chezmoi"
  "$HOME/.local/share/mise/shims/chezmoi"
  "$HOME/.cache/mise/chezmoi"
  "$HOME/Library/Caches/mise/chezmoi"
)

rm -rf -- "${paths[@]}"

remove_cache_entries() {
  local directory="$1"

  [[ -d "$directory" ]] || return 0
  find "$directory" -mindepth 1 -maxdepth 1 -iname "*chezmoi*" -exec rm -rf -- {} +
}

remove_cache_entries "$HOME/.cache/mise/github"
remove_cache_entries "$HOME/Library/Caches/Homebrew"
remove_cache_entries "$HOME/Library/Caches/mise/github"

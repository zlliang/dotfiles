#!/bin/sh

for path in \
  "$HOME/.profile" \
  "$HOME/.bash_profile" \
  "$HOME/.bash_login" \
  "$HOME/.bashrc" \
  "$HOME/.bash_logout" \
  "$HOME/.bash_history" \
  "$HOME/.bash_sessions" \
  "$HOME/.bash_completion" \
  "$HOME/.bash_completion.d" \
  "$HOME/.zshenv" \
  "$HOME/.zprofile" \
  "$HOME/.zshrc" \
  "$HOME/.zlogin" \
  "$HOME/.zlogout" \
  "$HOME/.zsh_history" \
  "$HOME/.zsh_sessions" \
  "$HOME"/.zcompdump*; do
  if [ -e "$path" ] || [ -L "$path" ]; then
    rm -rf -- "$path"
  fi

  compiled_path="$path.zwc"
  if [ -e "$compiled_path" ] || [ -L "$compiled_path" ]; then
    rm -rf -- "$compiled_path"
  fi
done

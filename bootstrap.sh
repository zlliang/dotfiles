#!/usr/bin/env bash

set -euo pipefail

DOTFILES_REPO="https://github.com/zlliang/dotfiles.git"
SOURCE_DIR="${SOURCE_DIR:-$HOME/workspace/github/zlliang/dotfiles}"

log() {
  printf '\n==> %s\n' "$*"
}

die() {
  printf 'error: %s\n' "$*" >&2
  exit 1
}

run_as_root() {
  sudo "$@"
}

install_linux_prerequisites() {
  if command -v apt-get >/dev/null 2>&1; then
    log "Installing system packages with apt"
    run_as_root apt-get update
    run_as_root env DEBIAN_FRONTEND=noninteractive apt-get install -y \
      build-essential ca-certificates curl file git procps python3
  elif command -v dnf >/dev/null 2>&1; then
    log "Installing system packages with dnf"
    if ! run_as_root dnf group install -y development-tools; then
      run_as_root dnf group install -y "Development Tools"
    fi
    run_as_root dnf install -y \
      ca-certificates curl file git procps-ng python3
  else
    die "Unsupported Linux distribution: apt-get or dnf is required"
  fi
}

install_macos_prerequisites() {
  if xcode-select -p >/dev/null 2>&1; then
    return
  fi

  log "Installing Xcode Command Line Tools"
  xcode-select --install >/dev/null 2>&1 || true
  printf 'Complete the installation dialog to continue.\n'
  until xcode-select -p >/dev/null 2>&1; do
    sleep 5
  done
}

find_brew() {
  local candidate

  if command -v brew >/dev/null 2>&1; then
    command -v brew
    return
  fi

  for candidate in \
    /opt/homebrew/bin/brew \
    /home/linuxbrew/.linuxbrew/bin/brew \
    /usr/local/bin/brew; do
    if [[ -x "$candidate" ]]; then
      printf '%s\n' "$candidate"
      return
    fi
  done

  return 1
}

if [[ ${EUID:-$(id -u)} -eq 0 ]]; then
  die "Run this script as a regular user, not root"
fi

command -v sudo >/dev/null 2>&1 || die "sudo is required"
run_as_root -v

case "$(uname -s)" in
  Darwin)
    install_macos_prerequisites
    ;;
  Linux)
    install_linux_prerequisites
    ;;
  *)
    die "Unsupported operating system: $(uname -s)"
    ;;
esac

if ! brew_path=$(find_brew); then
  log "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew_path=$(find_brew) || die "Homebrew was installed but brew could not be found"
fi

eval "$("$brew_path" shellenv)"

log "Installing bootstrap packages"
brew install chezmoi fish jq

if [[ -e "$SOURCE_DIR" && ! -d "$SOURCE_DIR/.git" ]]; then
  die "$SOURCE_DIR exists but is not a Git repository"
fi

if [[ -d "$SOURCE_DIR/.git" ]]; then
  log "Updating dotfiles repository"
  git -C "$SOURCE_DIR" pull --ff-only
fi

log "Initializing dotfiles"
chezmoi init -S "$SOURCE_DIR" --apply "$DOTFILES_REPO"

fish_path="$(brew --prefix)/bin/fish"
log "Bootstrap complete"
printf 'To make Fish your default shell, run:\n'
printf '  grep -qxF %q /etc/shells || echo %q | sudo tee -a /etc/shells\n' "$fish_path" "$fish_path"
printf '  chsh -s %q\n' "$fish_path"

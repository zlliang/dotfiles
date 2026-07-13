#!/usr/bin/env bash

set -euo pipefail

DOTFILES_REPO="https://github.com/zlliang/dotfiles.git"
SOURCE_DIR="${SOURCE_DIR:-$HOME/workspace/github/zlliang/dotfiles}"

BOLD=""
BLUE=""
CYAN=""
GREEN=""
RED=""
RESET=""

if [[ -t 1 && ${TERM:-dumb} != dumb && ${NO_COLOR+x} != x ]]; then
  BOLD=$'\033[1m'
  BLUE=$'\033[34m'
  CYAN=$'\033[36m'
  GREEN=$'\033[32m'
  RED=$'\033[31m'
  RESET=$'\033[0m'
fi

title() {
  printf '\n%s%sDotfiles bootstrap%s\n' "$BOLD" "$BLUE" "$RESET"
  printf 'Set up your development environment\n'
}

log() {
  local divider
  local message=$*

  printf -v divider '%*s' "${#message}" ''
  divider=${divider// /=}

  printf '\n%s%s%s%s\n%s%s%s\n%s%s%s%s\n' \
    "$BOLD" "$BLUE" "$divider" "$RESET" \
    "$BOLD" "$message" "$RESET" \
    "$BOLD" "$BLUE" "$divider" "$RESET"
}

note() {
  printf '%s%sNote:%s %s\n' "$BOLD" "$CYAN" "$RESET" "$*"
}

success() {
  printf '\n%s%s✓%s %s\n' "$BOLD" "$GREEN" "$RESET" "$*"
}

die() {
  printf '%s%serror:%s %s\n' "$BOLD" "$RED" "$RESET" "$*" >&2
  exit 1
}

run_as_root() {
  if [[ ${EUID:-$(id -u)} -eq 0 ]]; then
    "$@"
  else
    sudo "$@"
  fi
}

install_linux_packages() {
  if command -v apt-get >/dev/null 2>&1; then
    log "Installing system packages with apt"
    run_as_root apt-get update
    run_as_root apt-get install -y ca-certificates curl fish git
  elif command -v dnf >/dev/null 2>&1; then
    log "Installing system packages with dnf"
    run_as_root dnf update
    run_as_root dnf install -y ca-certificates curl fish git
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
  note "Complete the installation dialog to continue"
  until xcode-select -p >/dev/null 2>&1; do
    sleep 5
  done
}

set_default_shell() {
  local fish_path=$1
  local user

  user="$(id -un)"
  if ! grep -qxF "$fish_path" /etc/shells 2>/dev/null; then
    printf '%s\n' "$fish_path" | run_as_root tee -a /etc/shells >/dev/null
  fi

  if [[ ${SHELL:-} != "$fish_path" ]]; then
    log "Setting Fish as the default shell"
    run_as_root chsh -s "$fish_path" "$user"
  fi
}

title

os="$(uname -s)"
case "$os" in
  Darwin)
    [[ ${EUID:-$(id -u)} -ne 0 ]] || die "Do not run this script as root on macOS"
    command -v sudo >/dev/null 2>&1 || die "sudo is required"
    run_as_root -v

    install_macos_prerequisites

    log "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew_path="/opt/homebrew/bin/brew"

    log "Installing Fish"
    "$brew_path" install fish

    fish_path="$("$brew_path" --prefix)/bin/fish"
    ;;
  Linux)
    if [[ ${EUID:-$(id -u)} -ne 0 ]]; then
      command -v sudo >/dev/null 2>&1 || die "sudo is required"
      run_as_root -v
    fi

    install_linux_packages

    fish_path="$(command -v fish)"
    ;;
  *)
    die "Unsupported operating system: $os"
    ;;
esac

log "Installing mise"
curl -fsSL https://mise.run | sh
mise_path="$HOME/.local/bin/mise"

log "Installing chezmoi"
"$mise_path" install chezmoi@latest
chezmoi_path="$("$mise_path" which chezmoi --tool chezmoi@latest)"

log "Initializing dotfiles"
"$chezmoi_path" init --verbose -S "$SOURCE_DIR" --apply "$DOTFILES_REPO"

log "Setting Fish as the default shell"
set_default_shell "$fish_path"
success "Bootstrap complete. Restart your shell to finish."

#!/usr/bin/env bash

set -euo pipefail

DOTFILES_REPO="https://github.com/zlliang/dotfiles.git"
SOURCE_DIR="${SOURCE_DIR:-$HOME/workspace/github/zlliang/dotfiles}"
HOMEBREW_USER="linuxbrew"
HOMEBREW_HOME="/home/$HOMEBREW_USER"
HOMEBREW_PREFIX="$HOMEBREW_HOME/.linuxbrew"

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
  printf '\n%s%s==>%s %s%s%s\n' "$BOLD" "$BLUE" "$RESET" "$BOLD" "$*" "$RESET"
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

create_linuxbrew_user() {
  local group

  if ! id "$HOMEBREW_USER" >/dev/null 2>&1; then
    log "Creating $HOMEBREW_USER user"
    useradd --create-home --shell /bin/bash "$HOMEBREW_USER"
  fi

  group="$(id -gn "$HOMEBREW_USER")"
  if [[ ! -d $HOMEBREW_HOME ]]; then
    install -d -m 0755 -o "$HOMEBREW_USER" -g "$group" "$HOMEBREW_HOME"
  else
    chown "$HOMEBREW_USER:$group" "$HOMEBREW_HOME"
  fi

  if [[ ! -d $HOMEBREW_PREFIX ]]; then
    install -d -m 0755 -o "$HOMEBREW_USER" -g "$group" "$HOMEBREW_PREFIX"
  elif [[ $(stat -c %u "$HOMEBREW_PREFIX") != "$(id -u "$HOMEBREW_USER")" ]]; then
    chown -R "$HOMEBREW_USER:$group" "$HOMEBREW_PREFIX"
  fi
}

run_as_homebrew_user() {
  if [[ ${EUID:-$(id -u)} -eq 0 ]]; then
    (
      cd "$HOMEBREW_HOME"
      runuser -u "$HOMEBREW_USER" -- env \
        HOME="$HOMEBREW_HOME" USER="$HOMEBREW_USER" LOGNAME="$HOMEBREW_USER" "$@"
    )
  else
    "$@"
  fi
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
  note "Complete the installation dialog to continue"
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

title

os="$(uname -s)"
if [[ ${EUID:-$(id -u)} -eq 0 ]]; then
  [[ $os == Linux ]] || die "Running as root is supported only on Linux"
  command -v runuser >/dev/null 2>&1 || die "runuser is required"
  command -v useradd >/dev/null 2>&1 || die "useradd is required"
  create_linuxbrew_user
else
  command -v sudo >/dev/null 2>&1 || die "sudo is required"
  run_as_root -v
fi

case "$os" in
  Darwin)
    install_macos_prerequisites
    ;;
  Linux)
    install_linux_prerequisites
    ;;
  *)
    die "Unsupported operating system: $os"
    ;;
esac

if ! brew_path=$(find_brew); then
  log "Installing Homebrew"
  run_as_homebrew_user env NONINTERACTIVE=1 /bin/bash -c \
    "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew_path=$(find_brew) || die "Homebrew was installed but brew could not be found"
fi

eval "$(run_as_homebrew_user "$brew_path" shellenv)"

log "Installing bootstrap packages"
run_as_homebrew_user "$brew_path" install chezmoi fish jq

if [[ -e "$SOURCE_DIR" && ! -d "$SOURCE_DIR/.git" ]]; then
  die "$SOURCE_DIR exists but is not a Git repository"
fi

if [[ -d "$SOURCE_DIR/.git" ]]; then
  log "Updating dotfiles repository"
  git -C "$SOURCE_DIR" pull --ff-only
fi

log "Initializing dotfiles"
chezmoi init -S "$SOURCE_DIR" --apply "$DOTFILES_REPO"

fish_path="$(run_as_homebrew_user "$brew_path" --prefix)/bin/fish"
success "Bootstrap complete. To make Fish your default shell:"
if [[ ${EUID:-$(id -u)} -eq 0 ]]; then
  printf '\n%sgrep -qxF %q /etc/shells || echo %q >> /etc/shells%s\n' \
    "$CYAN" "$fish_path" "$fish_path" "$RESET"
else
  printf '\n%sgrep -qxF %q /etc/shells || echo %q | sudo tee -a /etc/shells%s\n' \
    "$CYAN" "$fish_path" "$fish_path" "$RESET"
fi
printf '%schsh -s %q%s\n\n' "$CYAN" "$fish_path" "$RESET"

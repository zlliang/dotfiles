#!/usr/bin/env bash

set -euo pipefail

DOTFILES_REPO="${DOTFILES_REPO:-https://github.com/zlliang/dotfiles.git}"
SOURCE_DIR="$HOME/workspace/github/zlliang/dotfiles"
MISE_INSTALL_PATH="${MISE_INSTALL_PATH:-$HOME/.local/bin/mise}"
MISE_INSTALL_SKIP_IF_EXISTS="${MISE_INSTALL_SKIP_IF_EXISTS:-1}"
PROFILE="${PROFILE:-personal}"
WORK_CONFIG_NEEDS_SETUP=false

BOLD=$'\033[1m'
CYAN=$'\033[36m'
RED=$'\033[31m'
GREEN=$'\033[32m'
RESET=$'\033[0m'

if [[ -n "${NO_COLOR:-}" ]]; then
  BOLD=""
  CYAN=""
  RED=""
  GREEN=""
  RESET=""
fi

print_title() {
  printf "\n%s%s%s%s\n%s\n" \
    "$BOLD" \
    "$CYAN" \
    "Zilong's Dotfiles" \
    "$RESET" \
    "Personal dotfiles and development environment for macOS and Linux, managed by mise"
}

log() {
  printf "\n%s%s==>%s %s%s%s\n" "$BOLD" "$CYAN" "$RESET" "$BOLD" "$*" "$RESET"
}

die() {
  printf "%s%serror:%s %s\n" "$BOLD" "$RED" "$RESET" "$*" >&2
  exit 1
}

run_as_root() {
  if (( EUID == 0 )); then
    "$@"
  else
    sudo "$@"
  fi
}

install_prerequisites() {
  case "$(uname -s)" in
    Darwin)
      (( EUID != 0 )) || die "Do not run this script as root on macOS"
      [[ "$(uname -m)" == "arm64" ]] || die "Only Apple Silicon macOS is supported"

      if ! xcode-select -p >/dev/null 2>&1; then
        log "Installing Xcode Command Line Tools"
        xcode-select --install >/dev/null 2>&1 || true
        until xcode-select -p >/dev/null 2>&1; do sleep 5; done
      fi

      if [[ ! -x "/opt/homebrew/bin/brew" ]]; then
        log "Installing Homebrew"
        NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        export PATH="/opt/homebrew/bin:$PATH"
      fi
      ;;
    Linux)
      if (( EUID != 0 )); then
        command -v sudo >/dev/null 2>&1 || die "sudo is required"
      fi

      if command -v apt-get >/dev/null 2>&1; then
        log "Installing bootstrap dependencies with apt"
        run_as_root apt-get update
        run_as_root apt-get install -y ca-certificates curl git
      elif command -v dnf >/dev/null 2>&1; then
        log "Installing bootstrap dependencies with dnf"
        run_as_root dnf install -y ca-certificates curl git
      else
        die "Unsupported Linux distribution: apt-get or dnf is required"
      fi
      ;;
    *)
      die "Unsupported operating system: $(uname -s)"
      ;;
  esac
}

validate_profile() {
  [[ "$PROFILE" == "personal" || "$PROFILE" == "work" ]] || die "PROFILE must be personal or work"
}

write_profile_config() {
  local config_dir="$HOME/.config/mise"
  local local_config="$config_dir/config.work.local.toml"

  [[ "$PROFILE" == "work" ]] || return 0
  mkdir -p "$config_dir"

  if [[ ! -f "$local_config" ]]; then
    cp "$SOURCE_DIR/mise.work.local.toml.example" "$local_config"
  fi

  ln -sfn "$local_config" "$SOURCE_DIR/mise.work.local.toml"
  if grep -q "= \"\"\$" "$local_config"; then
    WORK_CONFIG_NEEDS_SETUP=true
  fi
}

print_title
validate_profile
install_prerequisites

log "Installing mise"
curl -fsSL https://mise.run | \
  MISE_INSTALL_PATH="$MISE_INSTALL_PATH" \
  MISE_INSTALL_SKIP_IF_EXISTS="$MISE_INSTALL_SKIP_IF_EXISTS" sh
export PATH="$(dirname "$MISE_INSTALL_PATH"):$PATH"

if [[ ! -e "$SOURCE_DIR" ]]; then
  log "Cloning dotfiles"
  git clone "$DOTFILES_REPO" "$SOURCE_DIR"
elif [[ ! -d "$SOURCE_DIR/.git" ]]; then
  die "$SOURCE_DIR exists but is not a Git repository"
fi

write_profile_config

cd "$SOURCE_DIR"

log "Trusting the dotfiles configuration"
"$MISE_INSTALL_PATH" trust --all
"$MISE_INSTALL_PATH" trust --show

log "Bootstrapping the machine"
MISE_AUTO_ENV=1 MISE_ENV="$PROFILE" "$MISE_INSTALL_PATH" bootstrap --yes --force-dotfiles

printf "\n%sBootstrap complete. Restart your shell to finish.%s\n" "$GREEN" "$RESET"
if [[ "$WORK_CONFIG_NEEDS_SETUP" == "true" ]]; then
  printf "Fill in %s and rerun bootstrap to apply the work settings.\n" \
    "$HOME/.config/mise/config.work.local.toml"
fi

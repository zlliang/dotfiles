# Fish shell settings
# Location: $HOME/.config/fish/config.fish

# Environment variables and general settings
set -gx LANG "en_US.UTF-8"
set -gx SSH_KEY_PATH "$HOME/.ssh/rsa_id"
set -gx EDITOR "code --wait"
fish_add_path -g "$HOME/.local/bin"
fish_add_path -g "$HOME/Workspace/shared/bin"
stty -echoctl 2>/dev/null # Disable `^C` display when pressing Ctrl+C

# Set cursor style to `line` internally
# 1 -> blinking block
# 2 -> solid block
# 3 -> blinking underscore
# 4 -> solid underscore
# 5 -> blinking vertical bar
# 6 -> solid vertical bar
echo -ne "\e[5 q"
function postexec --on-event fish_postexec; echo -ne "\e[5 q"; end

# Homebrew
if string match -q Darwin (uname)
  set -gx HOMEBREW_PREFIX "/opt/homebrew"
  set -gx HOMEBREW_CELLAR "/opt/homebrew/Cellar"
  set -gx HOMEBREW_REPOSITORY "/opt/homebrew"
  set -gx HOMEBREW_BOTTLE_DOMAIN "https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
  fish_add_path -g "/opt/homebrew/bin" "/opt/homebrew/sbin"
end

# System utilities
if type -q eza
  alias ls "eza -lhH --no-quotes --git --time-style='long-iso'"
  alias la "ls -al"
  alias l "ls"
end
if type -q bat
  alias cat "bat"
  if string match -q Darwin (uname)
      if defaults read -g AppleInterfaceStyle >/dev/null 2>&1
          set -gx BAT_THEME "default"
      else
          set -gx BAT_THEME "GitHub"
      end
  end
end
if type -q zoxide
    zoxide init fish | source
end

# VS Code
# Enable key-repeating for Vim plugin. See https://marketplace.visualstudio.com/items?itemName=vscodevim.vim.
if string match -q Darwin (uname)
  defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
  # defaults delete -g ApplePressAndHoldEnabled # If necessary, reset global default
end

# Node
# Use `nodenv` to manage Node.js versions. See https://github.com/nodenv/nodenv.
if type -q nodenv
  nodenv init - fish | source
  # Use `pnpm` as package manager. See https://pnpm.io/.
  set -gx PNPM_HOME "$HOME/.pnpm"
  fish_add_path -g "$PNPM_HOME"
end
# Prevent corepack from updating the `packageManager` field
set -gx COREPACK_ENABLE_AUTO_PIN 0

# Go
if type -q go
  set -gx GOPATH "$HOME/.golang"
  set -gx GOENV "$GOPATH/env"
  fish_add_path -g "$GOPATH/bin"
end

# Python
# Use `pyenv` to manage Python versions. See https://github.com/pyenv/pyenv.
if type -q pyenv
  pyenv init - fish | source
end
# Suppress default virtual env prompt
set -gx VIRTUAL_ENV_DISABLE_PROMPT "true"

# Rust
if type -q cargo
  fish_add_path -g "$HOME/.cargo/bin"
end

# gitignore.io
function gi -d "Create .gitignore files"
  curl -sL https://www.toptal.com/developers/gitignore/api/$argv
end

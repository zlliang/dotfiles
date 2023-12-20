# Fish shell settings
# Location: $HOME/.config/fish/config.fish

# Environment variables
set -gx LC_ALL en_US.UTF-8
set -gx SSH_KEY_PATH $HOME/.ssh/rsa_id
set -gx PATH $HOME/.local/bin $PATH

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
if test (uname) = Darwin
  set -gx HOMEBREW_PREFIX /opt/homebrew
  set -gx HOMEBREW_CELLAR /opt/homebrew/Cellar
  set -gx HOMEBREW_REPOSITORY /opt/homebrew
  set -gx HOMEBREW_BOTTLE_DOMAIN https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles
  set -gx PATH /opt/homebrew/bin /opt/homebrew/sbin $PATH
end

# System utilities
if command -q eza
  alias ls "eza -lhH --git --time-style='long-iso'"
  alias la "ls -al"
  alias l "ls"
end

# VS Code
# Enable key-repeating for Vim plugin. See https://marketplace.visualstudio.com/items?itemName=vscodevim.vim.
if test (uname) = Darwin
  defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
  # defaults delete -g ApplePressAndHoldEnabled # If necessary, reset global default
end

# Node
# Use `n` to manage Node.js versions. See https://github.com/tj/n.
set -gx N_PREFIX $HOME/.node
set -gx N_NODE_MIRROR https://npmmirror.com/mirrors/node
set -gx PATH $HOME/.node/bin $PATH
# Use `pnpm` as package manager. See https://pnpm.io/.
set -gx PNPM_HOME $HOME/Library/pnpm
set -gx PATH $PNPM_HOME $PATH

# Go
set -gx GOPATH $HOME/.golang
set -gx GOENV $GOPATH/env
set -gx PATH $GOPATH/bin $PATH

# Rust
set -gx PATH $HOME/.cargo/bin $PATH

# Python
# Use `pyenv` to manage Python versions. See https://github.com/pyenv/pyenv.
pyenv init - fish | source
set -gx VIRTUAL_ENV_DISABLE_PROMPT true
# Use `poetry` to manage Python dependencies. See https://python-poetry.org/.
set -gx POETRY_HOME $HOME/.poetry
set -gx PATH $POETRY_HOME/bin $PATH
set -gx POETRY_VIRTUALENVS_PREFER_ACTIVE_PYTHON true

# Ruby
# Use `rbenv` to manage Ruby versions. See https://github.com/rbenv/rbenv.
rbenv init - fish | source

# Java (OpenJDK)
# set -gx JAVA_HOME (/usr/libexec/java_home)

# Docker
set -gx PATH $HOME/.docker/bin $PATH

# bat
if command -q bat
  alias cat "bat"
  if command -q defaults
    if test [(defaults read -g AppleInterfaceStyle 2> /dev/null)] # Dark mode
      set -gx BAT_THEME "default"
    else # Light mode
      set -gx BAT_THEME "GitHub"
    end
  end
end

# zoxide
if command -q zoxide
  zoxide init fish | source
end

# gitignore.io
function gi -d "gitignore.io: Create useful .gitignore files"
  curl -sL https://gitignore.io/api/$argv
end

# Set proxy
function set-proxy -d "Set web proxy"
  set -gx https_proxy "http://127.0.0.1:7890"
  set -gx http_proxy "http://127.0.0.1:7890"
  set -gx all_proxy "socks5://127.0.0.1:7890"
end

# Work at Tencent
set -gx PATH $HOME/tencent/workspace/bin $PATH

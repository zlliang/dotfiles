# Fish shell settings
# Location: $HOME/.config/fish/config.fish

# Environment variables
set -gx LC_ALL C
set -gx SSH_KEY_PATH $HOME/.ssh/rsa_id
set -gx PATH $HOME/.local/bin $PATH

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

# Node
# Use `n` to manage Node.js versions. See https://github.com/tj/n.
set -gx N_PREFIX $HOME/.node
set -gx N_NODE_MIRROR https://npmmirror.com/mirrors/node
set -gx PATH $HOME/.node/bin $PATH

# Node pnpm
set -gx PNPM_HOME $HOME/Library/pnpm
set -gx PATH $PNPM_HOME $PATH

# Rust
set -gx PATH $HOME/.cargo/bin $PATH

# Java (OpenJDK)
# set -gx JAVA_HOME (/usr/libexec/java_home)

# Go
set -gx GOPATH $HOME/.golang
set -gx GOENV $GOPATH/env
set -gx PATH $GOPATH/bin $PATH

# Python
set -gx PATH /opt/homebrew/opt/python/libexec/bin $PATH
set -gx VIRTUAL_ENV_DISABLE_PROMPT true

# Ruby
# Use`rbenv` to manage Ruby versions. See https://github.com/rbenv/rbenv.
rbenv init - fish | source

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

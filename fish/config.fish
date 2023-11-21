# Fish shell settings
# Location: $HOME/.config/fish/config.fish

# Environment variables
set -x LANG en_US.UTF-8
set -x SSH_KEY_PATH $HOME/.ssh/rsa_id
set -x PATH $HOME/.local/bin $PATH

# Secret
if test -f $__fish_config_dir/secret.fish
  source $__fish_config_dir/secret.fish
end

# Homebrew
if test (uname) = Darwin
  set -x HOMEBREW_PREFIX /opt/homebrew
  set -x HOMEBREW_CELLAR /opt/homebrew/Cellar
  set -x HOMEBREW_REPOSITORY /opt/homebrew
  set -x HOMEBREW_BOTTLE_DOMAIN https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles
  set -x PATH /opt/homebrew/bin /opt/homebrew/sbin $PATH
  # set -x MANPATH /opt/homebrew/share/man $MANPATH
  # set -x INFOPATH /opt/homebrew/share/info $INFOPATH
end

# System utilities
alias ls "eza -lhH --git --time-style='long-iso'"
alias la "ls -al"
alias l "ls"

# Node (Use `n` to manage Node.js versions)
set -x N_PREFIX $HOME/.node
set -x N_NODE_MIRROR https://npmmirror.com/mirrors/node
set -x PATH $HOME/.node/bin $PATH

# Node - pnpm
set -x PNPM_HOME $HOME/Library/pnpm
set -x PATH $PNPM_HOME $PATH

# Rust
set -x PATH $HOME/.cargo/bin $PATH

# Java (OpenJDK)
# set -x JAVA_HOME (/usr/libexec/java_home)

# Go
set -x GOPATH $HOME/.golang
set -x GOENV $GOPATH/env
set -x PATH $GOPATH/bin $PATH

# Python
set -x PATH /opt/homebrew/opt/python@3.11/libexec/bin $PATH
set -x VIRTUAL_ENV_DISABLE_PROMPT true

# Docker
set -x PATH $HOME/.docker/bin $PATH

# bat
if command -q defaults
  if test [(defaults read -g AppleInterfaceStyle 2> /dev/null)] # Dark mode
    set -x BAT_THEME ""
  else # Light mode
    set -x BAT_THEME "GitHub"
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
  export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890
end

# Working related
set -x PATH $HOME/tencent/workspace/bin $PATH

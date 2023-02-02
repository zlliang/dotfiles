# Fish shell settings
# Location: ~/.config/fish/config.fish

# Environment variables
set -x LANG en_US.UTF-8
set -x SSH_KEY_PATH $HOME/.ssh/rsa_id
set -x PATH $HOME/.local/bin $PATH

# Homebrew
set -x HOMEBREW_PREFIX /opt/homebrew
set -x HOMEBREW_CELLAR /opt/homebrew/Cellar
set -x HOMEBREW_REPOSITORY /opt/homebrew
set -x HOMEBREW_BOTTLE_DOMAIN https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles
set -x PATH /opt/homebrew/bin /opt/homebrew/sbin $PATH
# set -x MANPATH /opt/homebrew/share/man $MANPATH
# set -x INFOPATH /opt/homebrew/share/info $INFOPATH

# System utilities
alias ls "exa -lhH --git --time-style='long-iso'"
alias la "ls -al"
alias l "ls"

# Node (Use `n` to manage Node.js versions)
set -x N_PREFIX $HOME/.node
set -x N_NODE_MIRROR https://npmmirror.com/mirrors/node
set -x PATH $HOME/.node/bin $PATH

# Rust
# set -x PATH $HOME/.cargo/bin $PATH

# Java (OpenJDK)
# set -x JAVA_HOME (/usr/libexec/java_home)

# Go
set -x GOPATH $HOME/.golang
set -x GOENV $GOPATH/env
set -x PATH $GOPATH/bin $PATH

# Python
set -x PATH /opt/homebrew/opt/python@3.10/libexec/bin $PATH
set -x VIRTUAL_ENV_DISABLE_PROMPT true

# bat
if test [(defaults read -g AppleInterfaceStyle 2> /dev/null)]
  set -x BAT_THEME ""
else
  set -x BAT_THEME "GitHub"
end

# zoxide
zoxide init fish | source

# gitignore.io
function gi -d "gitignore.io: Create useful .gitignore files"
  curl -sL https://gitignore.io/api/$argv
end

# Job related
set -x PATH $HOME/tencent/workspace/bin $PATH

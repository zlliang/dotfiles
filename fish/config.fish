# Fish shell settings
# Location: ~/.config/fish/config.fish

# Environment variables
set -x LANG en_US.UTF-8
set -x SSH_KEY_PATH $HOME/.ssh/rsa_id
set -x HOMEBREW_BOTTLE_DOMAIN https://mirrors.ustc.edu.cn/homebrew-bottles

# System utilities
alias ls "exa -lhH --git --time-style='long-iso'"
alias l "ls"

# HTTP proxy
# set -x http_proxy  http://127.0.0.1:1087
# set -x https_proxy http://127.0.0.1:1087

# Node (Use `n` to manage Node.js versions)
set -x N_PREFIX $HOME/.node
set -x N_NODE_MIRROR https://npm.taobao.org/mirrors/node
set -x N_PRESERVE_NPM 1
set -x PATH $HOME/.node/bin $PATH

# Rust
set -x PATH $HOME/.cargo/bin $PATH

# Java (OpenJDK)
set -x JAVA_HOME (/usr/libexec/java_home)

# Python
set -x PATH /usr/local/opt/python/libexec/bin $PATH
set -x VIRTUAL_ENV_DISABLE_PROMPT true

# zoxide
zoxide init fish | source

# gitignore.io
function gi -d "gitignore.io: Create useful .gitignore files"
  curl -sL https://gitignore.io/api/$argv
end

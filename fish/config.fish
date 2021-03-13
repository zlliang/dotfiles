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
set -x http_proxy  http://127.0.0.1:1087
set -x https_proxy http://127.0.0.1:1087

# Rust
set -x PATH $HOME/.cargo/bin $PATH

# Go
set -x GOPATH $HOME/.golang
set -x GOENV $GOPATH/env
set -x GOPROXY https://goproxy.cn

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

# git.io
function gitio -d "git.io: Create short links for GitHub web pages"
  curl -si https://git.io -F "url=$argv" |
  grep "Location" |
  sed "s/Location: //"
end

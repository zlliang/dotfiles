# Fish shell configuration
# Location: ~/.config/fish/config.fish

# Environment variables
set -x LANG en_US.UTF-8
set -x SSH_KEY_PATH $HOME/.ssh/rsa_id
set -x HOMEBREW_BOTTLE_DOMAIN https://mirrors.ustc.edu.cn/homebrew-bottles
set -x PATH /usr/local/opt/python/libexec/bin $PATH  # Python symlinks

# System utilities
alias ls "exa -lhH --git --time-style='long-iso'"
alias l "ls"

# Java (OpenJDK)
set -x JAVA_HOME (/usr/libexec/java_home)

# TeX Live
set -x TLMGR_REPO "https://mirrors.ustc.edu.cn/CTAN/systems/texlive/tlnet/"
alias tlmgr "tlmgr --repository $TLMGR_REPO"

# Python
set -x VIRTUAL_ENV_DISABLE_PROMPT true

# autojump
if test -f /usr/local/share/autojump/autojump.fish
  source /usr/local/share/autojump/autojump.fish
end

# gitignore.io
function gi -d "gitignore.io: Create useful .gitignore files"
  curl -sL https://www.gitignore.io/api/$argv
end

# git.io
function gitio -d "git.io: Create short links for GitHub web pages"
  curl -si https://git.io -F "url=$argv" |
  grep "Location" |
  sed "s/Location: //"
end

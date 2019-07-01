# Oh-My-Zsh settings
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="liang"
plugins=(zsh-syntax-highlighting zsh-completions osx autojump brew git python
         node yarn rust rustup cargo gradle pip httpie travis)
source $ZSH/oh-my-zsh.sh

# Environment variables
export LANG="en_US.UTF-8"
export PATH="$HOME/.bin:/usr/local/opt/grep/libexec/gnubin:/usr/local/opt/make/libexec/gnubin:$PATH"
export SSH_KEY_PATH="$HOME/.ssh/rsa_id"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"


# C / C++ / Fortran / Intel Compilers
export CFLAGS="-I/usr/local/include -I/usr/local/include/eigen3"
alias clang="clang $CFLAGS"
alias clang++="clang++ --std=c++17 $CFLAGS"  # Use C++17 standard
export DYLD_LIBRARY_PATH="/opt/arrayfire/lib"
source /opt/intel/bin/compilervars.sh intel64

# TeX Live
export TLMGR_REPO="https://mirrors.ustc.edu.cn/CTAN/systems/texlive/tlnet/"
alias tlmgr="tlmgr --repository $TLMGR_REPO"

# Java (OpenJDK)
export JAVA_HOME=$(/usr/libexec/java_home)

# Python
alias activate="source ./venv/bin/activate"  # virtualenv
alias python="python3"
alias pip="pip3"
alias py="python"
alias ipy="ipython"
alias python2="/usr/bin/python"
alias py2="python2"

# Exa -- A modern replacement for ls
alias ls="exa -lhH --git --time-style='long-iso'"
alias la="ls -a"

# gitignore.io
function gi() { curl -L -s https://www.gitignore.io/api/$@; }

# git.io
function gitio() { 
  curl -s -i https://git.io -F "url=$@" |
  grep 'Location' |
  sed 's/Location: //';
}

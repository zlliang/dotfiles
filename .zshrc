# Oh-My-Zsh settings
export ZSH="/Users/Quincy/.oh-my-zsh"
ZSH_THEME="quincy"
plugins=(zsh-syntax-highlighting zsh-completions osx autojump brew git python
         node yarn rust cargo docker)
source $ZSH/oh-my-zsh.sh

# C, C++, Fortran and Intel Compilers
export CFLAGS="-I/usr/local/include"
export CPPFLAGS="-I/usr/local/include"
export LDFLAGS="-L/usr/local/lib"
source /opt/intel/bin/compilervars.sh intel64  # Intel Compilers
alias clang++="clang++ --std=c++17"

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

# Node.JS
export NODE_ENV="development"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Exa -- A modern replacement for ls
alias ls="exa -lhH --git --time-style='long-iso'"
alias la="ls -a"

# ENV
export LANG="en_US.UTF-8"
export PATH="$HOME/.bin:/usr/local/opt/make/libexec/gnubin:$PATH"
export SSH_KEY_PATH="$HOME/.ssh/rsa_id"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"

# gitignore.io
function gi() { curl -L -s https://www.gitignore.io/api/$@; }

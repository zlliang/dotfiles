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
  alias ls "eza -lhH --no-quotes --git --time-style='long-iso'"
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
# Use `nodenv` to manage Node.js versions. See https://github.com/nodenv/nodenv.
if command -q nodenv
  nodenv init - fish | source
  # Use `pnpm` as package manager. See https://pnpm.io/.
  set -gx PNPM_HOME $HOME/.pnpm
  set -gx PATH $PNPM_HOME $PATH
end
# Prevent corepack from updating the `packageManager` field
set -gx COREPACK_ENABLE_AUTO_PIN 0

# Go
if command -q go
  set -gx GOPATH $HOME/.golang
  set -gx GOENV $GOPATH/env
  set -gx PATH $GOPATH/bin $PATH
end

# # Rust
# if command -q cargo
#   set -gx PATH $HOME/.cargo/bin $PATH
# end

# # Python
# # Use `pyenv` to manage Python versions. See https://github.com/pyenv/pyenv.
# if command -q pyenv
#   pyenv init - fish | source
#   set -gx VIRTUAL_ENV_DISABLE_PROMPT true
# end

# # Ruby
# # Use `rbenv` to manage Ruby versions. See https://github.com/rbenv/rbenv.
# if command -q rbenv
#   rbenv init - fish | source
# end

# # Java (OpenJDK)
# # set -gx JAVA_HOME (/usr/libexec/java_home)

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
function gi -d "Create .gitignore files"
  curl -sL https://www.toptal.com/developers/gitignore/api/$argv
end

# Surge proxy
function proxy -d "Surge proxy"
  set -gx https_proxy "http://127.0.0.1:6152"
  set -gx http_proxy "http://127.0.0.1:6152"
  set -gx all_proxy "socks5://127.0.0.1:6153"
end
if functions -q proxy
  proxy
end

# Workspace path
set -gx PATH $HOME/Workspace/shared/bin $PATH

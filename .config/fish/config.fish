# Fish shell settings
# Location: $HOME/.config/fish/config.fish

# Environment variables and general settings
set -gx LANG "en_US.UTF-8"
set -gx SSH_KEY_PATH "$HOME/.ssh/rsa_id"
set -gx EDITOR "code --wait"
fish_add_path -g "$HOME/.local/bin"
stty -echoctl 2>/dev/null # Disable `^C` display when pressing Ctrl+C

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
if string match -q Darwin (uname)
  set -gx HOMEBREW_PREFIX "/opt/homebrew"
  set -gx HOMEBREW_CELLAR "/opt/homebrew/Cellar"
  set -gx HOMEBREW_REPOSITORY "/opt/homebrew"
  set -gx HOMEBREW_BOTTLE_DOMAIN "https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
  fish_add_path -g "/opt/homebrew/bin" "/opt/homebrew/sbin"
end

# System utilities
if type -q eza
  alias ls "eza -lhH --no-quotes --group-directories-first --git --time-style=long-iso"
  alias la "ls -a"
  alias tree "ls --tree --level=2"
end
if type -q bat
  alias cat "bat"
  if string match -q Darwin (uname)
      if defaults read -g AppleInterfaceStyle >/dev/null 2>&1
          set -gx BAT_THEME "default"
      else
          set -gx BAT_THEME "GitHub"
      end
  end
end
if type -q zoxide
    zoxide init fish | source
end

# VS Code
# Enable key-repeating for Vim plugin. See https://marketplace.visualstudio.com/items?itemName=vscodevim.vim.
if string match -q Darwin (uname)
  defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
  # defaults delete -g ApplePressAndHoldEnabled # If necessary, reset global default
end

# JavaScript
# Use `nodenv` to manage Node.js versions. See https://github.com/nodenv/nodenv.
if type -q nodenv
  nodenv init - fish | source
end
# Use `pnpm` as package manager. See https://pnpm.io/.
set -gx PNPM_HOME "$HOME/.pnpm"
fish_add_path -g "$PNPM_HOME"
# Prevent corepack from updating the `packageManager` field
set -gx COREPACK_ENABLE_AUTO_PIN 0

# Python
# Suppress default virtual env prompt
set -gx VIRTUAL_ENV_DISABLE_PROMPT "true"

# Zig
# Use `zvm` to manage Zig versions. See https://github.com/tristanisham/zvm.
set -gx ZVM_INSTALL "$HOME/.zvm/self"
fish_add_path -g "$HOME/.zvm/bin" "$ZVM_INSTALL"

# Workspace-specific
if test -d "$HOME/Workspace"
  set -gx WORKSPACE "$HOME/Workspace"
  fish_add_path -g "$WORKSPACE/.local/bin"
  test -f "$WORKSPACE/.config/fish/config.fish"; and source "$WORKSPACE/.config/fish/config.fish"
end

# Environment
set -gx LANG "en_US.UTF-8"
set -gx EDITOR "{{ "code --wait" if os() == "macos" else "vim" }}"
fish_add_path -g "$HOME/.local/bin"

{%- if os() == "macos" %}

# Homebrew
/opt/homebrew/bin/brew shellenv | source
set -gx HOMEBREW_NO_ENV_HINTS 1
set -gx HOMEBREW_NO_REQUIRE_TAP_TRUST 1

{%- endif %}

# mise
$HOME/.local/bin/mise activate fish --shims | source

# Interactive shell
if status is-interactive
  # Disable `^C` display when pressing Ctrl+C
  stty -echoctl 2>/dev/null

  # Set cursor style to `line` internally
  # 1 -> blinking block
  # 2 -> solid block
  # 3 -> blinking underscore
  # 4 -> solid underscore
  # 5 -> blinking vertical bar
  # 6 -> solid vertical bar
  echo -ne "\e[5 q"
  function postexec --on-event fish_postexec; echo -ne "\e[5 q"; end
end

# Utilities
if type -q eza
  alias ls "eza -lhH --no-quotes --group-directories-first --git --time-style=long-iso"
  alias la "ls -a"
  alias tree "ls --tree --level=2"
end
if type -q bat
  alias cat "bat"
end
if type -q zoxide
  zoxide init fish | source
end

# JavaScript
{%- if "work" in mise_env %}
set -gx COREPACK_NPM_REGISTRY "https://mirrors.tencent.com/npm"
set -gx COREPACK_INTEGRITY_KEYS "0"
{%- endif %}
set -gx COREPACK_ENABLE_AUTO_PIN 0
set -gx PNPM_HOME "$HOME/.pnpm"

# Python
set -gx VIRTUAL_ENV_DISABLE_PROMPT "true"

{%- if "work" in mise_env %}

# Work identity
set -gx USER_NAME "$USER"
set -gx WORK_EMAIL "{{ vars.WORK_EMAIL }}"
set -gx TEAM_NAME "{{ vars.TEAM_NAME }}"
set -gx TEAM_ID "{{ vars.TEAM_ID }}"

# Atlassian REST API
set -gx ATLASSIAN_SITE "{{ vars.ATLASSIAN_SITE }}"
set -gx ATLASSIAN_EMAIL "$WORK_EMAIL"
set -gx ATLASSIAN_API_TOKEN "{{ vars.ATLASSIAN_API_TOKEN }}"

# Sourcegraph CLI
set -gx SRC_ENDPOINT "{{ vars.SRC_ENDPOINT }}"

# Google Cloud SDK
if test -f "$HOME/.local/share/google-cloud-sdk/path.fish.inc"
  source "$HOME/.local/share/google-cloud-sdk/path.fish.inc"
end

# BK CLI
if type -q bk
  set -gx BK_AUTH_SSO_TIMEOUT 600000
end

# Booking Pages
fish_add_path -g "$HOME/.bpages/bin"

{%- endif %}

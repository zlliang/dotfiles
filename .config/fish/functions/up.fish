# Location: $HOME/.config/fish/functions/up.fish

function up -d "Update all developer tools"
  if type -q brew
    set_color --bold yellow
    echo "======== Updating: Homebrew ========"
    set_color normal

    brew update
    brew upgrade
    brew cleanup
  end

  if type -q nodenv; and type -q curl
    set_color --bold yellow
    echo "======== Updating: Node.js (LTS) ========"
    set_color normal

    set -l node_index (curl -fsSL https://nodejs.org/dist/index.tab)
    set -l latest_lts (printf '%s\n' $node_index | awk 'NR > 1 && $10 != "-" {gsub(/^v/, "", $1); print $1; exit}')
    if test -z "$latest_lts"
      echo "Failed to resolve latest LTS Node.js version"
      return 1
    end

    echo "Installing Node.js $latest_lts via nodenv..."
    nodenv install -s $latest_lts
    echo "Setting global Node.js version to $latest_lts..."
    nodenv global $latest_lts
    nodenv rehash
    echo "Enabling corepack..."
    corepack enable
  end

  if type -q zvm
    set_color --bold yellow
    echo "======== Updating: Zig ========"
    set_color normal

    zvm upgrade
    zvm i --zls master
  end

  if type -q amp
    set_color --bold yellow
    echo "======== Updating: Amp ========"
    set_color normal

    amp update
  end
end

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

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

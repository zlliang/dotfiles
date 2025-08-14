# Location: $HOME/.config/fish/functions/fish_prompt.fish

function fish_prompt
  set -l exit_status $status
  set -l git_branch (command git rev-parse --abbrev-ref HEAD 2>/dev/null)
  set -l pwd_str (prompt_pwd)
  
  # Date, time and working directory
  echo -n \n
  set_color --bold $fish_color_cwd
  echo -n $pwd_str " "
  set_color normal

  # Git info
  if command -q git; and test -n "$git_branch"
    set_color blue
    echo -n [
    echo -n git:$git_branch (echo_git_status)
    set_color blue
    echo -n ] " "
  end

  # JS info
  echo_js

  # Go info
  echo_golang

  # Rust info
  echo_rust

  # Python venv info
  echo_venv

  # Background jobs
  echo -n (echo_jobs)

  # User prompt
  echo -n \n
  set_color blue
  test -n "$SSH_CONNECTION" && echo -n "$USER"@(prompt_hostname) ""
  set_color green
  test $exit_status != 0 && set_color red
  set_color --bold
  echo -n "> "
  set_color normal
end

function extract_version_number
  read -l str
  echo $str | rg -o "\d+(\.\d+)+"
end

function echo_git_status
  set -l git_status (command git status -uno --porcelain 2>/dev/null)
  if test -z "$git_status"
    set_color green
    echo "(clean)"
  else
    set_color red
    echo "(dirty)"
  end
end

function echo_js
  if file_in_tree package.json; and command -q node
    set_color green
    echo -n [
    echo -n "node:"
    echo -n (node --version | extract_version_number)
    echo -n ] " "
    set_color normal
  end

  if file_in_tree package.json; and file_in_tree bun.lockb; and command -q bun
    set_color yellow
    echo -n [
    echo -n "bun:"
    echo -n (bun --version | extract_version_number)
    echo -n ] " "
    set_color normal
  end
end

function echo_golang
  if file_in_tree go.mod; and command -q go
    set_color cyan
    echo -n [
    echo -n "go:"
    echo -n (go version | extract_version_number)
    echo -n ] " "
    set_color normal
  end
end

function echo_rust
  if file_in_tree Cargo.toml; and command -q rustc
    set_color yellow
    echo -n [
    echo -n "rust:"
    echo -n (rustc --version | extract_version_number)
    echo -n ] " "
    set_color normal
  end
end

function echo_venv
  if test (echo $PATH | grep "venv"); and command -q python
    set_color yellow
    echo -n [
    echo -n "python:"
    echo -n (python --version | extract_version_number)
    echo -n " (venv)"] " "
    set_color normal
  end
end

function echo_jobs
  set -l njobs (jobs | wc -l | xargs)
  set_color $fish_color_autosuggestion
  if test $njobs -le 0
    return
  else if test $njobs = 1
    echo "[$njobs job]"
  else
    echo "[$njobs jobs]"
  end
end

function file_in_tree -d "Check if a specific file is in the current tree"
  set -l filename $argv
  set -l dir (pwd)
  set -l root "/"
  while test $dir != $root
    if test -f $dir/$filename
      return 0
    end
    set dir (dirname $dir)
  end
  return 1
end

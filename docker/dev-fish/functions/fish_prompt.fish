# Fish shell settings for dev containers
# Author: Zilong Liang

function fish_prompt -d "Fish prompt for dev containers"
  set -l exit_status $status
  set -l git_branch (command git rev-parse --abbrev-ref HEAD 2>/dev/null)
  set -l pwd_str (prompt_pwd)
  
  # Working directory
  echo -n \n
  set_color $fish_color_cwd
  echo -n $pwd_str " "

  # Git info
  if test -n "$git_branch"
    set_color cyan
    echo -n [
    echo -n git:$git_branch (echo_git_status)
    set_color cyan
    echo -n ] " "
  end

  # Node info
  echo_node

  # venv info
  echo_venv

  # User prompt
  echo -n \n
  set_color blue
  echo -n "$USER"@(prompt_hostname) ""
  set_color green
  test $exit_status != 0 && set_color red
  set_color --bold
  echo -n "> "
  set_color normal
end

function echo_git_status -d "Auxiliary function to print git status"
  set -l __status (command git status --porcelain 2>/dev/null)
  if test -z "$__status"
    set_color green
    echo "(clean)"
  else
    set_color red
    echo "(dirty)"
  end
end

function echo_node -d "Auxiliary function to print Node info"
  if test -f package.json || test -f ../package.json || test -f ../../package.json ||\
     test -f ../../../package.json || test -f ../../../../package.json ||\
     test -f ../../../../../package.json || test -f ../../../../../../package.json ||\
     test -f ../../../../../../../package.json
    set_color green
    echo -n [
    echo -n "node:"
    set_color cyan
    echo -n (node --version | sed "s/v//")
    set_color green
    echo -n ] " "
    set_color normal
  end
end

function echo_venv -d "Auxiliary function to print virtualenv info"
  if test (echo $PATH | rg ".venv/bin")
    set_color yellow
    echo -n [
    set_color cyan
    echo -n "venv:"
    set_color yellow
    echo -n "python:"
    echo -n (python --version | sed "s/Python //")
    echo -n ] " "
    set_color normal
  end
end

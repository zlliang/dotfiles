# Location: ~/.config/fish/functions/fish_prompt.fish

function fish_prompt -d "Rich fish prompt"
  set -l exit_status $status
  set -l time_str (date "+%m-%d %H:%M")
  set -l git_branch (command git rev-parse --abbrev-ref HEAD 2>/dev/null)
  set -l pwd_str (prompt_pwd)
  
  # Date and time
  echo -n \n
  set_color yellow
  echo -n $time_str " "
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

  # Pipenv info
  echo_pipenv

  # Node info
  echo_node

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

function echo_pipenv -d "Auxiliary function to print Pipenv info"
  if test -f Pipfile || test -f ../Pipfile || test -f ../../Pipfile ||\
     test -f ../../../Pipfile || test -f ../../../../Pipfile ||\
     test -f ../../../../../Pipfile || test -f ../../../../../../Pipfile ||\
     test -f ../../../../../../../Pipfile
    set_color yellow
    echo -n [
    echo -n "pipenv:"
    if test (echo $PATH | grep "virtualenv")
      set -l python_version (python --version | sed "s/Python //")
      set_color green
      echo -n $python_version
      set_color yellow
    else
      set_color red
      echo -n "not-active"
      set_color yellow
    end
    echo -n ] " "
    set_color normal
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

function echo_jobs -d "Auxiliary function to print background jobs number"
  set -l njobs (jobs | wc -l | xargs)
  test -n (echo (jobs | grep autojump 2>/dev/null)) && set njobs (math $njobs-1)
  set_color $fish_color_autosuggestion
  if test $njobs -le 0
    return
  else if test $njobs = 1
    echo "[$njobs job]"
  else
    echo "[$njobs jobs]"
  end
end

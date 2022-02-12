# Location: ~/.config/fish/functions/fish_prompt.fish

function fish_prompt -d "Rich fish prompt"
  set exit_status $status
  set time_str (date "+%m-%d %H:%M")
  set git_branch (command git rev-parse --abbrev-ref HEAD 2>/dev/null)
  set pwd_str (prompt_pwd)
  
  # Date, time and working directory
  echo -n \n
  set_color blue
  echo -n $time_str " "
  set_color $fish_color_cwd
  echo -n $pwd_str " "

  # Git info
  if test -n "$git_branch"
    set_color blue
    echo -n [
    echo -n git:$git_branch (echo_git_status)
    set_color blue
    echo -n ] " "
  end

  # Node info
  echo_node

  # Rust info
  echo_rust

  # Go info
  echo_golang

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

function echo_git_status -d "Print git status"
  set git_status (command git status --porcelain 2>/dev/null)
  if test -z "$git_status"
    set_color green
    echo "(clean)"
  else
    set_color red
    echo "(dirty)"
  end
end

function echo_node -d "Print Node.js info"
  if file_in_tree package.json
    set_color green
    echo -n [
    echo -n "node:"
    echo -n (node --version | rg "\d+(\.\d+)+" -o)
    echo -n ] " "
    set_color normal
  end
end

function echo_rust -d "Print Rust info"
  if file_in_tree Cargo.toml
    set_color yellow
    echo -n [
    echo -n "rust:"
    echo -n (rustc --version | rg "\d+(\.\d+)+" -o)
    echo -n ] " "
    set_color normal
  end
end

function echo_golang -d "Print Go info"
  if file_in_tree go.mod
    set_color cyan
    echo -n [
    echo -n "go:"
    echo -n (go version | rg "\d+(\.\d+)+" -o)
    echo -n ] " "
    set_color normal
  end
end

function echo_venv -d "Print Python virtualenv info"
  if test (echo $PATH | rg ".venv/bin")
    set_color yellow
    echo -n [
    echo -n "venv:"
    echo -n "python:"
    echo -n (python --version | rg "\d+\.\d+\.\d" -o)
    echo -n ] " "
    set_color normal
  end
end

function echo_jobs -d "Print background jobs number"
  set njobs (jobs | wc -l | xargs)
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
  set filename $argv
  set dir (pwd)
  set root "/"
  while test $dir != $root
    if test -f $dir/$filename
      return 0
    end
    set dir (dirname $dir)
  end
  return 1
end

# Location: $HOME/.config/fish/functions/fish_prompt.fish

function fish_prompt
  set -l pwd_seg (string join '' (set_color $fish_color_cwd --bold) (prompt_pwd) (set_color normal) ' ')
  set -l git_seg (__prompt_git)
  set -l js_seg (__prompt_js)
  set -l golang_seg (__prompt_golang)
  set -l rust_seg (__prompt_rust)
  set -l venv_seg (__prompt_venv)
  set -l jobs_seg (__prompt_jobs)
  set -l host_seg (__prompt_host)
  set -l arrow_seg (__prompt_arrow)

  printf '\n%s' (string join '' $pwd_seg $git_seg $js_seg $golang_seg $rust_seg $venv_seg $jobs_seg)
  printf '\n%s' (string join '' $host_seg $arrow_seg)
end

function __prompt_git
  if type -q git; else
    return
  end

  set -l is_git (command git rev-parse --is-inside-work-tree 2>/dev/null)
  if string match -q true $is_git; else
    return
  end

  set -l git_branch (command git rev-parse --abbrev-ref HEAD 2>/dev/null)
  if test -n $git_branch; else
    return
  end

  set -l dirty 0
  command git diff --quiet --ignore-submodules HEAD -- 2>/dev/null
  or set dirty 1
  command git diff --cached --quiet 2>/dev/null
  or set dirty 1

  set -l state (string join '' (set_color green) '(clean)' (set_color normal))
  if test $dirty -eq 1
    set state (string join '' (set_color red) '(dirty)' (set_color normal))
  end

  string join '' (set_color blue) '[git:' $git_branch ' ' $state (set_color blue) ']' (set_color normal) ' '
end

function __prompt_js
  set -l node ''
  if __file_in_tree package.json; and type -q node
    set node (string join '' (set_color green) '[node:' (node --version | __version_number) ']' (set_color normal) ' ')
  end

  set -l bun ''
  if __file_in_tree package.json; and __file_in_tree bun.lock; and type -q bun
    set bun (string join '' (set_color yellow) '[bun:' (bun --version | __version_number) ']' (set_color normal) ' ')
  end
  
  string join '' $node $bun
end

function __prompt_golang
  set -l golang ''
  if __file_in_tree go.mod; and type -q go
    set golang (string join '' (set_color cyan) '[go:' (go version | __version_number) ']' (set_color normal) ' ')
  end

  string join '' $golang
end

function __prompt_rust
  set -l rust ''
  if __file_in_tree Cargo.toml; and type -q rustc
    set rust (string join '' (set_color yellow) '[rust:' (rustc --version | __version_number) ']' (set_color normal) ' ')
  end

  string join '' $rust
end

function __prompt_venv
  set -l venv ''
  if set -q VIRTUAL_ENV; and type -q python
    set venv (string join '' (set_color yellow) '[python:' (python --version | __version_number) ' (venv)]' (set_color normal) ' ')
  end

  string join '' $venv
end

function __prompt_jobs
  set -l n (jobs | count)
  if test $n -eq 0
    return
  end

  echo -n (string join '' (set_color $fish_color_autosuggestion) (if test $n -eq 1; echo "[1 job] "; else; echo "[$n jobs] "; end) (set_color normal) ' ')
end

function __prompt_host
  if set -q SSH_CONNECTION
    string join '' (set_color blue) $USER'@'(prompt_hostname) (set_color normal)
  end
end

function __prompt_arrow
  string join '' (if test $status -eq 0; echo (set_color green --bold); else; echo (set_color red --bold); end) '> ' (set_color normal)
end

function __version_number
  read -l s
  string match -r '[0-9]+\.[0-9]+\.[0-9]+(?:-[0-9A-Za-z.-]+)?(?:\+[0-9A-Za-z.-]+)?' -- $s
end

function __file_in_tree -d "Check if a specific file is in the current tree"
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

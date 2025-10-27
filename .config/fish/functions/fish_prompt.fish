# Location: $HOME/.config/fish/functions/fish_prompt.fish

function fish_prompt
  set -l pwd_seg (string join '' (set_color $fish_color_cwd --bold) (prompt_pwd) (set_color normal) ' ')
  set -l git_seg (__prompt_git)
  set -l js_seg (__prompt_js)
  set -l python_seg (__prompt_python)
  set -l golang_seg (__prompt_golang)
  set -l rust_seg (__prompt_rust)
  set -l zig_seg (__prompt_zig)
  set -l jobs_seg (__prompt_jobs)
  set -l host_seg (__prompt_host)
  set -l arrow_seg (__prompt_arrow)

  printf '\n%s' (string join '' $pwd_seg $git_seg $js_seg $python_seg $golang_seg $rust_seg $zig_seg $jobs_seg)
  printf '\n%s' (string join '' $host_seg $arrow_seg)
end

function __prompt_git
  type -q git; or return
  git rev-parse --is-inside-work-tree >/dev/null 2>&1; or return

  set -l ref (git symbolic-ref --quiet --short HEAD 2>/dev/null; or git describe --exact-match --tags HEAD 2>/dev/null; or git rev-parse --short HEAD 2>/dev/null)

  set -l dirty 0
  git diff --no-ext-diff --quiet --ignore-submodules -- 2>/dev/null; or set dirty 1
  git diff --no-ext-diff --cached --quiet --ignore-submodules -- 2>/dev/null; or set dirty 1
  set -l untracked (git ls-files --others --exclude-standard --directory --no-empty-directory 2>/dev/null)
  test -n "$untracked"; and set dirty 1

  set -l state (string join '' (set_color green) '(clean)' (set_color normal))
  test $dirty -eq 1; and set state (string join '' (set_color red) '(dirty)' (set_color normal))

  string join '' (set_color blue) '[git:' $ref ' ' $state (set_color blue) ']' (set_color normal) ' '
end

function __prompt_js
  set -l node ''
  if type -q node; and __file_in_tree package.json
    set node (string join '' (set_color green) '[node:' (node --version | __version_number) ']' (set_color normal) ' ')
  end

  set -l bun ''
  if type -q bun; and __file_in_tree package.json; and __file_in_tree bun.lock
    set bun (string join '' (set_color yellow) '[bun:' (bun --version | __version_number) ']' (set_color normal) ' ')
  end
  
  string join '' $node $bun
end

function __prompt_python
  set -l python ''
  if type -q python
    if set -q VIRTUAL_ENV
      set python (string join '' (set_color yellow) '[python:' (python --version | __version_number) ' (venv)]' (set_color normal) ' ')
    else if __file_in_tree pyproject.toml
      set python (string join '' (set_color yellow) '[python:' (python --version | __version_number) ']' (set_color normal) ' ')
    end
  end

  string join '' $python
end

function __prompt_golang
  set -l golang ''
  if type -q go; and __file_in_tree go.mod
    set golang (string join '' (set_color cyan) '[go:' (go version | __version_number) ']' (set_color normal) ' ')
  end

  string join '' $golang
end

function __prompt_rust
  set -l rust ''
  if type -q rustc; and __file_in_tree Cargo.toml
    set rust (string join '' (set_color yellow) '[rust:' (rustc --version | __version_number) ']' (set_color normal) ' ')
  end

  string join '' $rust
end

function __prompt_zig
  set -l zig ''
  if type -q zig; and __file_in_tree build.zig
    set zig (string join '' (set_color yellow) '[zig:' (zig version | __version_number) ']' (set_color normal) ' ')
  end

  string join '' $zig
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

function fish_prompt
  set -l last_status $status
  set -l pwd_seg (string join "" (set_color $fish_color_cwd --bold) (prompt_pwd) (set_color normal) " ")
  set -l venv_seg (__prompt_venv)
  set -l git_seg (__prompt_git)
  set -l jobs_seg (__prompt_jobs)
  set -l host_seg (__prompt_host)
  set -l arrow_seg (__prompt_arrow $last_status)

  printf "\n%s" (string join "" $pwd_seg $venv_seg $git_seg $jobs_seg)
  printf "\n%s" (string join "" $host_seg $arrow_seg)
end

function __prompt_venv
  set -q VIRTUAL_ENV; or return
  echo -n (string join "" (set_color yellow) "(venv)" (set_color normal) " ")
end

function __prompt_git
  set -l format "[git:%s] "
  fish_git_prompt $format
end

function __prompt_jobs
  set -l n (jobs | count)
  test $n -eq 0; and return

  echo -n (string join "" (set_color $fish_color_autosuggestion) (if test $n -eq 1; echo "[1 job]"; else; echo "[$n jobs]"; end) (set_color normal) " ")
end

function __prompt_host
  if set -q SSH_CONNECTION; or set -q container; or test -e /.dockerenv; or test -e /run/.containerenv
    string join "" (set_color blue) $USER "@" (prompt_hostname) (set_color normal)
  end
end

function __prompt_arrow
  set -l last_status $argv[1]
  string join "" (if test $last_status -eq 0; echo (set_color green --bold); else; echo (set_color red --bold); end) "> " (set_color normal)
end

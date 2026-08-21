function tdl -d "Open a tmux development layout at an optional path"
  set -l default_session "Personal"
  set -l new_pane_percent 35

  if test (count $argv) -gt 1
    printf "tdl: expected at most one path argument\n" >&2
    return 2
  end

  set -l path
  if set -q argv[1]
    if not test -d "$argv[1]"
      printf "tdl: not a directory: %s\n" "$argv[1]" >&2
      return 1
    end
    set path (path resolve -- "$argv[1]")
    or return
  end

  if not set -q TMUX
    if set -q path[1]
      tmux new-session -A -s "$default_session" -c "$path"
    else
      tmux new-session -A -s "$default_session"
    end
    return $status
  end

  set -l current_pane "$TMUX_PANE"
  if not set -q path[1]
    set path (tmux display-message -p -t "$current_pane" "#{pane_current_path}")
    or return
  end

  set -l target_pane "$current_pane"
  set -l pane_count (tmux display-message -p -t "$current_pane" "#{window_panes}")
  or return

  # Preserve populated windows; only reuse a window that still has one pane.
  if test "$pane_count" -gt 1
    set -l current_session (tmux display-message -p -t "$current_pane" "#{session_name}")
    or return
    set target_pane (tmux new-window -P -F "#{pane_id}" -t "$current_session:" -c "$path")
    or return
  end

  # Keep the top 65% high and its left side 65% wide.
  tmux split-window -v -p "$new_pane_percent" -c "$path" -t "$target_pane"
  or return
  set -l right_pane (tmux split-window -h -p "$new_pane_percent" -P -F "#{pane_id}" -c "$path" -t "$target_pane")
  or return

  # Unlike new panes created with -c, a reused pane must change directory itself.
  set -l escaped_path (string escape -- "$path")
  set -l nvim_command "cd -- $escaped_path; nvim ."
  tmux send-keys -t "$target_pane" "$nvim_command" C-m
  or return
  tmux send-keys -t "$right_pane" "pi" C-m
end

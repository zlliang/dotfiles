function tdl -d "Open a tmux development layout, inspired by Omarchy"
  set -l personal_session "Personal"

  if test (count $argv) -gt 1
    printf "tdl: expected at most one path argument\n" >&2
    return 2
  end

  set -l directory $argv
  if set -q directory[1]
    if not test -d "$directory"
      printf "tdl: not a directory: %s\n" "$directory" >&2
      return 1
    end
    set directory (path resolve -- "$directory"); or return
  end

  set -l current_pane
  if set -q TMUX
    set current_pane "$TMUX_PANE"
  else
    if not tmux has-session -t "$personal_session" 2>/dev/null
      if not set -q directory[1]
        set directory "$PWD"
      end
      # Match the terminal size; detached sessions otherwise default to 80x24.
      tmux new-session -d -s "$personal_session" -x "$COLUMNS" -y "$LINES" -c "$directory"; or return
    end

    set current_pane (tmux display-message -p -t "$personal_session:" "#{pane_id}"); or return
  end

  if not set -q directory[1]
    set directory (tmux display-message -p -t "$current_pane" "#{pane_current_path}"); or return
  end

  set -l editor_pane "$current_pane"
  set -l pane_count (tmux display-message -p -t "$current_pane" "#{window_panes}"); or return

  # Preserve populated windows; only reuse a window that still has one pane.
  if test "$pane_count" -gt 1
    set -l current_session (tmux display-message -p -t "$current_pane" "#{session_name}"); or return
    set editor_pane (tmux new-window -P -F "#{pane_id}" -t "$current_session:" -c "$directory"); or return
  end

  # Keep the top 65% high and its left side 65% wide.
  tmux split-window -v -p 35 -c "$directory" -t "$editor_pane"; or return
  set -l pi_pane (tmux split-window -h -p 35 -P -F "#{pane_id}" -c "$directory" -t "$editor_pane"); or return

  # New panes honor -c; a reused editor pane must change directory itself.
  set -l escaped_directory (string escape -- "$directory")
  set -l editor_command "cd -- $escaped_directory; nvim ."
  tmux send-keys -t "$editor_pane" "$editor_command" Enter; or return
  tmux send-keys -t "$pi_pane" "pi" Enter; or return
  tmux select-pane -t "$editor_pane"; or return

  if not set -q TMUX
    tmux attach-session -t "$personal_session"
  end
end

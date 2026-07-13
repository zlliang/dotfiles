if status is-interactive
  # Disable `^C` display when pressing Ctrl+C
  stty -echoctl 2>/dev/null

  # Set cursor style to `line` internally
  # 1 -> blinking block
  # 2 -> solid block
  # 3 -> blinking underscore
  # 4 -> solid underscore
  # 5 -> blinking vertical bar
  # 6 -> solid vertical bar
  echo -ne "\e[5 q"
  function postexec --on-event fish_postexec; echo -ne "\e[5 q"; end
end

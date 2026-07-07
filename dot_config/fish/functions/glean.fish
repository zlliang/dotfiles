function glean -d "Glean CLI wrapper: reroute the broken `auth login` to our OAuth script"
  if test (count $argv) -ge 2 -a "$argv[1]" = auth -a "$argv[2]" = login
    glean-auth-login
  else
    command glean $argv
  end
end

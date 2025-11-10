# Location: $HOME/.config/fish/functions/gi.fish

function gi -d "Create .gitignore files"
  curl -sL https://www.toptal.com/developers/gitignore/api/$argv
end

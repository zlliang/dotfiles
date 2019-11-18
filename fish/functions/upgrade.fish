# A script to upgrade development tools

function upgrade -d "Upgrade development tools"
  set_color --bold cyan
  echo "Programming Toolkits Upgrade"
  set_color normal

  set_color cyan
  echo "1) Homebrew"
  set_color normal
  brew update && brew upgrade && brew cleanup

  set_color cyan
  echo "2) Python"
  set_color normal
  pip_upgrade

  set_color cyan
  echo "3) Node (yarn)"
  set_color normal
  yarn global upgrade -s --latest

  set_color cyan
  echo "4) TeX Live"
  set_color normal
  tlmgr update --all

  set_color --bold cyan
  echo "Upgrade Completed"
  set_color normal
end

function pip_upgrade -d "Auxiliary function to upgrade outdated Python packages"
  set_color yellow
  echo "Finding outdated packages..."
  set_color normal
  set -l packages (pip3 list --outdated | awk 'NR>=3 {printf " %s",$1}' | sed 's/ //')
  set -l package_list (echo $packages | sed 's/ /, /g')
  if test -n "$packages"
    set_color yellow
    echo -n "Found: "
    set_color --bold
    echo $package_list
    set_color normal
    eval "pip3 install --upgrade $packages"
    set_color yellow
    echo "Successfully upgraded."
    set_color normal
  else
    set_color yellow
    echo "Everything is up-to-date."
    set_color normal
  end
end

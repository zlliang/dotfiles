# Dotfiles 🌚

Here are several dotfiles I am using on my macOS, and guides to configure a development environment.

## Configuration files

1. Fish shell: See [`fish/`](./fish/)
2. Git global configuration files: See [`.gitconfig`](./.gitconfig) and [`.gitignore`](./.gitignore)

To copy these configuration files to their appropriate locations, run [`install.sh`](./install.sh)

## Guide to configure a new Mac

1. Install _Xcode Command Line Tools_: run `xcode-select --install`
2. Install [Homebrew](https://brew.sh)
3. Install [Git](https://git-scm.com) and [Git-LFS](https://git-lfs.github.com) (via Homebrew)
4. Set [Fish](https://fishshell.com) as the default shell:
   - Install via Homebrew: `brew install fish`
   - Add `/opt/homebrew/bin/fish` to `/etc/shells`
   - Set the default shell: `chsh -s /opt/homebrew/bin/fish`
   - _Note that_ the configuration file of fish is `~/.config/fish/config.fish`
5. Programming language toolkits:
   - [`nodenv`](https://github.com/nodenv/nodenv) for [Node.js](https://nodejs.org)
   - [`go`](https://go.dev) (`brew install go`)
   <!--
   - [`rustup`](https://rustup.rs/) for Rust
   - [`pyenv`](https://github.com/pyenv/pyenv) for Python
   - [`rbenv`](https://github.com/rbenv/rbenv) for Ruby
   -->
6. Command line tools:
   - Essential:
      - [`eza`](https://github.com/eza-community/eza): A modern, maintained replacement for `ls`
      - [`fd`](https://github.com/sharkdp/fd): A simple, fast and user-friendly alternative to `find`
      - [`bat`](https://github.com/sharkdp/bat): A `cat` clone with wings
      - [`ripgrep (rg)`](https://github.com/BurntSushi/ripgrep): An alternative to `grep`
      - [`zoxide (z)`](https://github.com/ajeetdsouza/zoxide): A faster way to navigate your filesystem
   - Good to have:
      - [`tokei`](https://github.com/XAMPPRocky/tokei): Code counter
      - [`dust`](https://github.com/bootandy/dust): A more intuitive version of `du`
7. Desktop apps:
   - Essential:
      - [VS Code](https://code.visualstudio.com): The code editor
      - [Hidden Bar](https://github.com/dwarvesf/hidden) (`brew install hiddenbar`)
      - [Scroll Reverser](https://pilotmoon.com/scrollreverser/) (`brew install scroll-reverser`)
      - [IINA](https://iina.io/) (`brew install iina`)
      - [Keka](https://keka.io/) (`brew install keka`)
      - [Surge](https://nssurge.com/)
      - [Replaceicon](https://replacicon.app/)
   - Good to have:
      - [Proxyman](https://proxyman.io/) (`brew install proxyman`)
      - [Orbstack](https://orbstack.dev/) (`brew install orbstack`)
      - [Postman](https://postman.com/) (`brew install postman`) or [HTTPie](https://httpie.io/) (`brew install httpie`)
    

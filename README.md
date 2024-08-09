# Dotfiles 🌚

Here are several dotfiles I am using on my macOS, and guides to configure a development environment.

## Configuration files

1. Fish shell: See [`fish/`](./fish/)
2. VS Code: See [`vscode/`](./vscode/)
3. Git global configuration files: See [`.gitconfig`](./.gitconfig) and [`.gitignore`](./.gitignore)

To copy these configuration files to their appropriate locations, run [`install.sh`](./install.sh)

## Guide to configure a macOS

1. Install _Xcode Command Line Tools_: run `xcode-select --install`
2. Install [Homebrew](https://brew.sh)
3. Install [Git](https://git-scm.com) and [Git-LFS](https://git-lfs.github.com) (via Homebrew)
4. Set [Fish](https://fishshell.com) as the default shell:
   - Install via Homebrew: `brew install fish`
   - Add `/usr/local/bin/fish` to `/etc/shells`
   - Set the default shell: `chsh -s /usr/local/bin/fish`;
   - _Note that_ the configuration file of fish is `~/.config/fish/config.fish`
5. Useful command line tools:
   - [`eza`](https://github.com/eza-community/eza): A modern, maintained replacement for `ls`
   - [`fd`](https://github.com/sharkdp/fd): A simple, fast and user-friendly alternative to `find`
   - [`bat`](https://github.com/sharkdp/bat): A `cat` clone with wings
   - [`ripgrep (rg)`](https://github.com/BurntSushi/ripgrep): An algernative to `grep`
   - [`zoxide (z)`](https://github.com/ajeetdsouza/zoxide): A faster way to navigate your filesystem;
6. Language toolkits:
   - [`nodenv`](https://github.com/nodenv/nodenv) for Node.js
   - [`rustup`](https://rustup.rs/) for Rust
   - [`pyenv`](https://github.com/pyenv/pyenv) for Python
   <!-- - [`rbenv`](https://github.com/rbenv/rbenv) for Ruby; -->
7. Install [VS Code](https://code.visualstudio.com) as the code editor
8. Great utility apps
   - [Hidden Bar](https://github.com/dwarvesf/hidden) (`brew install hiddenbar`)
   - [Scroll Reverser](https://pilotmoon.com/scrollreverser/) (`brew install scroll-reverser`)
   - [IINA](https://iina.io/) (`brew install iina`)
   - [Surge](https://nssurge.com/)
9. Great apps for development
   - [Proxyman](https://proxyman.io/) (`brew install proxyman`)
   - [Orbstack](https://orbstack.dev/) (`brew install orbstack`)
   - [Postman](https://postman.com/) (`brew install postman`)

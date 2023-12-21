# Dotfiles 🌚

Here are several dotfiles I am using on my macOS, and guides to configure a development environment.

## Configuration files

1. Fish shell: See [`fish/`](./fish/);
2. VS Code: See [`vscode/`](./vscode/);
3. Git global configuration files: See [`.gitconfig`](./.gitconfig) and [`.gitignore`](./.gitignore).

To copy these configuration files to their appropriate locations, run [`install.sh`](./install.sh).

## Guide to configure a macOS

1. Install _Xcode Command Line Tools_: run `xcode-select --install`;
2. Install [Homebrew](https://brew.sh);
3. Install [Git](https://git-scm.com) and [Git-LFS](https://git-lfs.github.com) (via Homebrew);
4. Set [Fish](https://fishshell.com) as the default shell:
   - Install via Homebrew: `brew install fish`;
   - Add `/usr/local/bin/fish` to `/etc/shells`;
   - Set the default shell: `chsh -s /usr/local/bin/fish`;
   - _Note that_ the configuration file of fish is `~/.config/fish/config.fish`;
5. Useful command line tools:
   - [`eza`](https://github.com/eza-community/eza): A modern, maintained replacement for `ls`;
   - [`fd`](https://github.com/sharkdp/fd): A simple, fast and user-friendly alternative to `find`;
   - [`bat`](https://github.com/sharkdp/bat): A `cat` clone with wings;
   - [`ripgrep (rg)`](https://github.com/BurntSushi/ripgrep): An algernative to `grep`;
   - [`zoxide (z)`](https://github.com/ajeetdsouza/zoxide): A faster way to navigate your filesystem;
6. Language toolkits:
   - [`rustup`](https://rustup.rs/) for Rust;
   - [`nodenv`](https://github.com/nodenv/nodenv) for Node.js;
   - [`rbenv`](https://github.com/rbenv/rbenv) for Ruby;
   - [`pyenv`](https://github.com/pyenv/pyenv) for Python;
7. Install [MacTeX](http://tug.org/mactex/) for LaTeX typesetting: `brew install --cask mactex-no-gui`;
8. Install [VS Code](https://code.visualstudio.com) as the code editor.

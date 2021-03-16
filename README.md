# Dotfiles 🌚

Here are several dotfiles I am using on my macOS, and guides to configure a development environment.

## Configuration files

1. Fish shell: See [`fish/`](./fish/);
2. iTerm2: See [`iterm/`](./iterm);
3. VS Code: See [`vscode/`](./vscode/);
4. Git global configuration files: See [`.gitconfig`](./.gitconfig) and [`.gitignore`](./.gitignore);
5. Vim settings: See [`.vimrc`](./.vimrc).

To link these configuration files to their suggested locations, run [`hardlink.sh`](./hardlink.sh).

## Guide to configure a macOS

1. Install _Xcode Command Line Tools_: run `xcode-select --install`;
2. Install [Homebrew](https://brew.sh);
3. Install [Git](https://git-scm.com) and [Git-LFS](https://git-lfs.github.com) (via Homebrew);
4. Install [iTerm2](https://iterm2.com/);
5. Set [Fish](https://fishshell.com) as the default shell:
   - Install via Homebrew: `brew install fish`;
   - Add `/usr/local/bin/fish` to `/etc/shells`;
   - Set the default shell: `chsh -s /usr/local/bin/fish`;
   - _Note that_ the configuration file of fish is `~/.config/fish/config.fish`;
6. Useful command line tools:
   - [`exa`](https://the.exa.website): A modern replacement for `ls`;
   - [`fd`](https://github.com/sharkdp/fd): A simple, fast and user-friendly alternative to `find`;
   - [`bat`](https://github.com/sharkdp/bat): A `cat` clone with wings;
   - [`ripgrep (rg)`](https://github.com/BurntSushi/ripgrep): An algernative to `grep`;
   - [`zoxide (z)`](https://github.com/ajeetdsouza/zoxide): A faster way to navigate your filesystem;
   - [`tokei`](https://github.com/XAMPPRocky/tokei): Count your code, quickly;
   - [`dust`](https://github.com/bootandy/dust): A more intuitive version of du;
7. Useful Homebrew bottles:
   - Programming languages and tools: `openjdk`, `gradle`, `go`, `python`, `node`, `yarn`;
   - C/C++ tools and libraries: `cmake`, `boost`, `fmt`, `eigen`, `spdlog`;
8. Install [MacTeX](http://tug.org/mactex/) for LaTeX typesetting: `brew install --cask mactex-no-gui`;
9. Install [VS Code](https://code.visualstudio.com) as the code editor;

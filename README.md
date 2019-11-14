# Dotfiles 🌚

This repository contains several dotfiles I am using in daily development on macOS, and this README file also contains a guide to configure the developing environment.

## Configuration Files

1. VS Code files: See [`vscode/`](./vscode/)
2. Fish shell files: See [`fish/`](./fish/)
3. Git global configuration files: See [`.gitconfig`](./.gitconfig) and [`.gitignore`](./.gitignore)
4. Vim settings: See [`.vimrc`](./.vimrc)
5. Python pip settings: See [`pip.conf`](./pip.conf)

## Guide: Configure a macOS

1. Install XCode command line tools: Run `xcode-select --install`
1. Install [Homebrew](https://brew.sh)
2. Install [Git](https://git-scm.com) and [Git-LFS](https://git-lfs.github.com) (via Homebrew)
3. Set [Fish](https://fishshell.com) as the default shell:
   - Install via Homebrew: `brew install fish`
   - Add `/usr/local/bin/fish` to `/etc/shells`
   - Set the default shell: `chsh -s /usr/local/bin/fish`
   - *Note that* the configuration file of fish is `~/.config/fish/config.fish`
4. Useful command line tools:
   - [`exa`](https://the.exa.website): A modern replacement for `ls`
   - [`fd`](https://github.com/sharkdp/fd): A simple, fast and user-friendly alternative to `find`
   - [`bat`](https://github.com/sharkdp/bat): A `cat` clone with wings
   - [`ripgrep (rg)`](https://github.com/BurntSushi/ripgrep): An algernative to `grep`
   - [`tldr`](https://tldr.sh): Simplified and community-driven man pages
   - [`autojump (j)`](https://github.com/wting/autojump): A `cd` command that learns
5. Useful Homebrew bottles:
   - Languages and tools: `java` (via cask), `gradle`, `python`, `pipenv`, `node`, `yarn`, `cmake`
   - Libraries: `boost`, `fmt`, `openblas` (remember to run `link --force`), `hdf5`, `eigen`, `mpich`, `catch2`
6. Useful Python packages to install globally (via `pip3`): `black`, `pylint`, `pytest`, `pygments`, `numpy`, `scipy`, `pandas`, `bokeh`, `jupyter`
7. Install the code editor: [VS Code](https://code.visualstudio.com)

## Appendices

### Software mirrors
In China you usually suffer from the connection problems. See [USTC mirrors](https://mirrors.ustc.edu.cn), [TUNA mirrors](https://mirrors.tuna.tsinghua.edu.cn) and [Tencent Cloud mirrors](https://mirrors.cloud.tencent.com) to configure `homebrew`, `pypi`, `CTAN` and `npm` (`yarn`).

### Preferred Monospaced Fonts
- [IBM Plex Mono](https://www.ibm.com/plex/)
- [Fira Code](https://github.com/tonsky/FiraCode), with programming ligatures!

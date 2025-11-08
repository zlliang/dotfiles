# Dotfiles 🌚

Personal dotfiles and development environment configuration guide for macOS.

## Configuration files

These files mirror the typical layout of configuration files in the `$HOME` directory. To copy them to their appropriate locations, run [`install.sh`](./install.sh).

## Guide to configure a new Mac

1. Install _Xcode Command Line Tools_: run `xcode-select --install`
2. Install [Homebrew](https://brew.sh)
3. Install [Git](https://git-scm.com) and [Git-LFS](https://git-lfs.github.com) (`brew install git git-lfs`)
4. Set [Fish](https://fishshell.com) as the default shell:
   - Install via Homebrew: `brew install fish`
   - Add `/opt/homebrew/bin/fish` to `/etc/shells`
   - Set the default shell: `chsh -s /opt/homebrew/bin/fish`
   - Note: fish configuration file is located at `~/.config/fish/config.fish`
5. Programming language toolkits:
   - JavaScript: [`nodenv`](https://github.com/nodenv/nodenv) for [Node.js](https://nodejs.org), and [`bun`](https://bun.com)
   - Python: [`uv`](https://docs.astral.sh/uv/)
   - [Zig](https://ziglang.org): [`zvm`](https://github.com/tristanisham/zvm)
6. Command line tools:
   - Essential:
      - [`eza`](https://github.com/eza-community/eza): a modern, maintained replacement for `ls`
      - [`fd`](https://github.com/sharkdp/fd): a simple, fast and user-friendly alternative to `find`
      - [`bat`](https://github.com/sharkdp/bat): a `cat` clone with wings
      - [`ripgrep (rg)`](https://github.com/BurntSushi/ripgrep): an alternative to `grep`
      - [`zoxide (z)`](https://github.com/ajeetdsouza/zoxide): a faster way to navigate your filesystem
   - Good to have:
      - [`tokei`](https://github.com/XAMPPRocky/tokei): code counter
      - [`dust`](https://github.com/bootandy/dust): a more intuitive version of `du`
      - [`btop`](https://github.com/aristocratos/btop): a terminal monitor of system resources
      - [`fastfetch`](https://github.com/fastfetch-cli/fastfetch): a neofetch-like system information tool
      - [`hyperfine`](https://github.com/sharkdp/hyperfine): a command-line benchmarking tool
7. Desktop apps:
   - Essential:
      - [VS Code](https://code.visualstudio.com): the code editor
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

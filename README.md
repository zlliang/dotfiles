# Dotfiles 🌚

Personal dotfiles and development environment for macOS, managed by [chezmoi](https://www.chezmoi.io/).

## Quick start

1. Install [Xcode Command Line Tools](https://developer.apple.com/xcode/): `xcode-select --install`
2. Install [Homebrew](https://brew.sh)
3. Install the bootstrap dependencies and initialize chezmoi:

    ```bash
    brew install chezmoi fish
    chezmoi init --apply https://github.com/zlliang/dotfiles.git
    ```

    I use `~/workspace/github/zlliang/dotfiles` as the source directory, so for me:

    ```bash
    chezmoi init -S ~/workspace/github/zlliang/dotfiles --apply https://github.com/zlliang/dotfiles.git
    ```

    Fish is needed while the post-apply scripts load the newly applied shell environment. The command installs the remaining packages and coding agents, then applies their configuration.

4. Set [Fish](https://fishshell.com) as the default shell:

    ```bash
    echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells
    chsh -s /opt/homebrew/bin/fish
    ```

5. After initialized, just update the latest changes regularly:

    ```bash
    chezmoi update
    ```

## What's included

### Packages

- **Shell:** [fish](https://fishshell.com)
- **Dev toolkits:** [fnm](https://github.com/Schniz/fnm), [bun](https://bun.sh), [uv](https://docs.astral.sh/uv/), [rustup](https://rustup.rs/)
- **CLI tools:** [bat](https://github.com/sharkdp/bat), [eza](https://github.com/eza-community/eza), [fd](https://github.com/sharkdp/fd), [ripgrep](https://github.com/BurntSushi/ripgrep), [zoxide](https://github.com/ajeetdsouza/zoxide), [gh](https://github.com/cli/cli), [fastfetch](https://github.com/fastfetch-cli/fastfetch), [hyperfine](https://github.com/sharkdp/hyperfine)
- **System utilities:** [chezmoi](https://www.chezmoi.io/), [Mole](https://github.com/tw93/Mole), [FFmpeg](https://ffmpeg.org/), [Chore](https://github.com/zlliang/chore)
- **Desktop apps:** [Ghostty](https://ghostty.org), [Keka](https://keka.io/), [OrbStack](https://orbstack.dev/), [Thaw](https://github.com/stonerl/Thaw)

### Coding agents

- [Amp](https://ampcode.com/)
- [Pi](https://pi.dev/)

### Configuration

- **Fish**: shell config and custom functions (`~/.config/fish/`)
- **Git**: conditional personal/work identity (`~/.gitconfig`)
- **Ghostty**: terminal config (`~/.config/ghostty/`)
- **Vim**: editor config (`~/.vimrc`)
- **Amp & Pi**: coding agent configs and global skills
- **MCPorter**: MCP server registry (`~/.mcporter/`)
- **`~/.local/bin`**: helper scripts

## Structure

This is a chezmoi source directory. Files use chezmoi naming conventions (`dot_`, `.tmpl`, `run_onchange_`, etc.) and are applied to `~` via `chezmoi apply`.

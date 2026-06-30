# Dotfiles 🌚

Personal dotfiles and development environment for macOS, managed by [chezmoi](https://www.chezmoi.io/).

## Quick start

1. Install [Xcode Command Line Tools](https://developer.apple.com/xcode/): `xcode-select --install`
2. Install [Homebrew](https://brew.sh)
3. Bootstrap everything:

    ```bash
    brew install chezmoi
    chezmoi init --apply https://github.com/zlliang/dotfiles.git
    ```

    I use `~/workspace/github/zlliang/dotfiles` as the source directory, so for me:

    ```bash
    chezmoi init -S ~/workspace/github/zlliang/dotfiles --apply https://github.com/zlliang/dotfiles.git
    ```

    This automatically installs Homebrew packages listed below, installs coding agents, and applies configuration for all tools.

4. Set [Fish](https://fishshell.com) as default shell:

   ```bash
   echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells
   chsh -s /opt/homebrew/bin/fish
   ```

5. After initialized, just update the latest changes regularly:

    ```bash
    chezmoi update
    ```

## What's included

### Homebrew packages

- **Shell:** [fish](https://fishshell.com)
- **Dev toolkits:** [nodenv](https://github.com/nodenv/nodenv), [bun](https://bun.sh), [uv](https://docs.astral.sh/uv/)
- **CLI tools:** [bat](https://github.com/sharkdp/bat), [eza](https://github.com/eza-community/eza), [fd](https://github.com/sharkdp/fd), [ripgrep](https://github.com/BurntSushi/ripgrep), [zoxide](https://github.com/ajeetdsouza/zoxide), [gh](https://github.com/cli/cli), [fastfetch](https://github.com/fastfetch-cli/fastfetch), [hyperfine](https://github.com/sharkdp/hyperfine)
- **System utilities:** [chezmoi](https://www.chezmoi.io/), [Mole](https://github.com/tw93/Mole)
- **Desktop apps:** [Ghostty](https://ghostty.org), [Hidden Bar](https://github.com/dwarvesf/hidden), [Keka](https://keka.io/), [OrbStack](https://orbstack.dev/)

### Coding agents

- [Amp](https://ampcode.com/)
- [Pi](https://pi.dev/)

### Configuration

- **Fish**: shell config and custom functions (`~/.config/fish/`)
- **Git**: conditional personal/work identity (`~/.gitconfig`)
- **Ghostty**: terminal config (`~/.config/ghostty/`)
- **Amp & Pi**: coding agent configs and global skills

## Structure

This is a chezmoi source directory. Files use chezmoi naming conventions (`dot_`, `.tmpl`, `run_onchange_`, etc.) and are applied to `~` via `chezmoi apply`.

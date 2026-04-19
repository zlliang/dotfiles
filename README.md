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

    I use `~/Workspace/github/zlliang/dotfiles` as the source directory, so for me:

    ```bash
    chezmoi init -S ~/Workspace/github/zlliang/dotfiles --apply https://github.com/zlliang/dotfiles.git
    ```

    This automatically runs `brew bundle` to install all packages below.

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
- **Dev toolkits:** [nodenv](https://github.com/nodenv/nodenv), [bun](https://bun.sh), [uv](https://docs.astral.sh/uv/), [go](https://go.dev)
- **CLI tools:** [bat](https://github.com/sharkdp/bat), [eza](https://github.com/eza-community/eza), [fd](https://github.com/sharkdp/fd), [ripgrep](https://github.com/BurntSushi/ripgrep), [zoxide](https://github.com/ajeetdsouza/zoxide), [gh](https://github.com/cli/cli), [fastfetch](https://github.com/fastfetch-cli/fastfetch), [hyperfine](https://github.com/sharkdp/hyperfine)
- **System utilities:** [chezmoi](https://www.chezmoi.io/), [Mole](https://github.com/tw93/Mole)
- **Desktop apps:** [Ghostty](https://ghostty.org), [Hidden Bar](https://github.com/dwarvesf/hidden), [IINA](https://iina.io/), [Keka](https://keka.io/), [OrbStack](https://orbstack.dev/), [Postman](https://postman.com/)

### Configuration

- **Fish**: shell config and custom functions (`~/.config/fish/`)
- **Git**: conditional personal/work identity (`~/.gitconfig`)
- **Ghostty**: terminal config (`~/.config/ghostty/`)
- **Amp / Codex / Claude Code**: coding agent configs and global skills

### Coding agents

- **[Amp](https://ampcode.com/)**: my primary coding agent ([profile](https://ampcode.com/@zlliang))
- **[Codex](https://openai.com/codex)**: CLI and standalone app, via ChatGPT Plus
- **[Claude Code](https://claude.com/product/claude-code)**: CLI only, via my company's API gateway (work laptop) and [Vercel AI Gateway](https://vercel.com/ai-gateway) (personal laptop)

## Structure

This is a chezmoi source directory. Files use chezmoi naming conventions (`dot_`, `.tmpl`, `run_onchange_`, etc.) and are applied to `~` via `chezmoi apply`.

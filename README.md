# Dotfiles 🌚

Personal dotfiles and development environment for macOS and Linux, managed by [chezmoi](https://www.chezmoi.io/).

## Quick start

Run the bootstrap script as a regular user:

```bash
curl -fsSL https://raw.githubusercontent.com/zlliang/dotfiles/main/bootstrap.sh | bash
```

Set `SOURCE_DIR` on the Bash process to use a different chezmoi source directory:

```bash
curl -fsSL https://raw.githubusercontent.com/zlliang/dotfiles/main/bootstrap.sh | SOURCE_DIR="$HOME/.local/share/chezmoi" bash
```

The script supports macOS and Linux distributions using apt or dnf. It installs the system prerequisites, Homebrew, Fish, and chezmoi, then applies the dotfiles and installs the remaining packages. On macOS, complete the Xcode Command Line Tools dialog if prompted.

After initialization, update the environment regularly:

```bash
chezmoi update
```

## What's included

### Packages

- **Shell:** [fish](https://fishshell.com)
- **Dev toolkits:** [Python](https://www.python.org/), [fnm](https://github.com/Schniz/fnm), [bun](https://bun.sh), [uv](https://docs.astral.sh/uv/), [rustup](https://rustup.rs/)
- **CLI tools:** [bat](https://github.com/sharkdp/bat), [eza](https://github.com/eza-community/eza), [fd](https://github.com/sharkdp/fd), [jq](https://jqlang.org/), [ripgrep](https://github.com/BurntSushi/ripgrep), [zoxide](https://github.com/ajeetdsouza/zoxide), [gh](https://github.com/cli/cli)
- **System utilities:** [chezmoi](https://www.chezmoi.io/), [Mole](https://github.com/tw93/Mole)
- **Coding agents:** [Amp](https://ampcode.com/), [Pi](https://pi.dev/)
- **Desktop apps:** [Ghostty](https://ghostty.org), [Keka](https://keka.io/), [OrbStack](https://orbstack.dev/), [Thaw](https://github.com/stonerl/Thaw)

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

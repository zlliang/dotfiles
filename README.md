# Dotfiles 🌚

Personal dotfiles and development environment for macOS and Linux, managed by [chezmoi](https://www.chezmoi.io/).

## Quick start

Run the bootstrap script:

```bash
curl -fsSL https://raw.githubusercontent.com/zlliang/dotfiles/main/bootstrap.sh | bash
```

Set `SOURCE_DIR` on the Bash process to use a different chezmoi source directory:

```bash
curl -fsSL https://raw.githubusercontent.com/zlliang/dotfiles/main/bootstrap.sh | SOURCE_DIR="$HOME/.local/share/chezmoi" bash
```

The script supports macOS and Linux distributions using apt or dnf. It installs necessary system dependencies and [mise](https://mise.jdx.dev/), applies the dotfiles, installs the remaining tools, and sets Fish as the default shell.

After initialization, update the environment regularly:

```bash
chezmoi update
```

## Structure

This is a chezmoi source directory. Files use chezmoi naming conventions (`dot_`, `.tmpl`, `run_onchange_`, etc.) and are applied to `~` via `chezmoi apply`.

# Dotfiles 🌚

Personal dotfiles and development environment for macOS and Linux, managed by [mise](https://mise.jdx.dev/).

## Quick start

```bash
curl -fsSL https://raw.githubusercontent.com/zlliang/dotfiles/main/bootstrap.sh | bash
```

Use the work profile when needed:

```bash
curl -fsSL https://raw.githubusercontent.com/zlliang/dotfiles/main/bootstrap.sh | PROFILE=work bash
```

The work profile copies `mise.work.local.toml.example` to `~/.config/mise/config.work.local.toml`. Fill in the placeholders and rerun bootstrap.

The stage-zero script installs prerequisites and mise, clones this repository, selects the machine profile, then runs:

```bash
mise bootstrap --yes
```

Inspect or update the environment with:

```bash
mise -C ~/workspace/github/zlliang/dotfiles bootstrap status
mise -C ~/workspace/github/zlliang/dotfiles bootstrap --dry-run
mise run update
```

## Structure

- `mise.toml` — bootstrap orchestration and dotfiles
- `mise.macos.toml`, `mise.linux.toml`, `mise.work.toml` — scoped machine configuration
- `src/` — copied and rendered user configuration, mirroring target paths

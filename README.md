# Dotfiles 🌚

Personal dotfiles and development environment for macOS and Linux, managed by [mise](https://mise.jdx.dev/).

## Quick start

Set up a fresh machine with one command:

```bash
curl -fsSL https://raw.githubusercontent.com/zlliang/dotfiles/main/bootstrap.sh | bash
```

Or with the work profile:

```bash
curl -fsSL https://raw.githubusercontent.com/zlliang/dotfiles/main/bootstrap.sh | PROFILE=work bash
```

This stage-zero script installs system prerequisites (Xcode Command Line Tools and Homebrew on macOS; curl and git on Linux) and mise, clones this repository to `~/workspace/github/zlliang/dotfiles`, and runs [`mise bootstrap`](https://mise.jdx.dev/bootstrap.html) under the chosen profile.

The work profile needs a few machine-local values: the script seeds the gitignored `mise.work.local.toml` from [`mise.work.local.toml.example`](mise.work.local.toml.example). Fill in the placeholders and rerun `mise bootstrap`.

## Configuration layout

[`.miserc.toml`](.miserc.toml) enables [`auto_env`](https://mise.jdx.dev/configuration/environments.html), so mise composes the configuration from layered files selected by platform and profile:

- [`mise.toml`](mise.toml): shared config — the dotfile map and dated one-time migrations that run as a final bootstrap hook
- [`mise.macos.toml`](mise.macos.toml) & [`mise.linux.toml`](mise.linux.toml): OS-specific packages, dotfiles, and user settings, loaded automatically on the matching platform
- [`mise.work.toml`](mise.work.toml): work-specific dotfiles, loaded when the work profile is active
- `mise.work.local.toml` (gitignored): per-machine `[vars]` for the work profile, consumed by templates

The profile chosen at bootstrap persists beyond the first run: `~/.config/mise/miserc.toml` is itself a managed dotfile ([`src/config/mise/miserc.toml`](src/config/mise/miserc.toml)) that records the active config environments, so later mise invocations keep the same profile without setting any environment variables.

## Dotfiles

Dotfile sources live under [`src`](src), mirroring the layout of the home directory. The default mode is `template`: each source renders through the [mise template engine](https://mise.jdx.dev/templates.html), so one file can produce different output per profile — for example, [`src/AGENTS.md`](src/AGENTS.md) includes work-specific sections only when the `work` profile is active, and [`src/config/mise/config.work.toml`](src/config/mise/config.work.toml) fills in values from `mise.work.local.toml`. Fully managed directories use `copy` mode instead.

Everything converges through `mise bootstrap`: it installs OS packages, applies dotfiles, sets the login shell, and installs mise-managed tools, skipping whatever is already in the desired state. Useful commands:

```bash
mise bootstrap                  # converge the machine
mise bootstrap status           # inspect every declarative part
mise dotfiles status            # applied / missing / differs, per entry
mise dotfiles apply --dry-run   # preview dotfile changes
```

## Tools and tasks

Daily tools and routines live in the rendered global config, [`src/config/mise/config.toml`](src/config/mise/config.toml), with work additions in [`src/config/mise/config.work.toml`](src/config/mise/config.work.toml).

The `mise run update` task keeps a machine current: it pulls this repository, reruns `mise bootstrap`, and upgrades system packages, mise itself, managed tools, and AI agents and their skills.

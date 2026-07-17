# Dotfiles

## Read the README first

@README.md

## Cleaning up stale dotfiles

mise dotfiles is stateless and never deletes: applying an entry only writes or overwrites its declared target, so whatever stops being declared is left behind — a removed entry's file, a renamed target's old path, an edit entry's block or line. Copy-mode directories are additive too: files absent from the source are left in place.

Whenever a change makes a previously managed path stale — renaming, moving, splitting, or merging dotfiles; removing an entry from `[dotfiles]`; removing or renaming a file under a copy-mode source directory — add a dated cleanup line to `[bootstrap.hooks.final]` in [mise.toml](mise.toml) in the same commit, so machines that applied the old state converge. Example:

```toml
# 2026-07-17: the tm prompt was renamed to cm; drop the stale copy.
"rm -f ~/.pi/agent/prompts/tm.md",
```

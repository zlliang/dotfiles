# Dotfiles (chezmoi source directory)

This repository is a [chezmoi](https://www.chezmoi.io/) **source directory**. It is not meant to be used directly — chezmoi reads files from here and applies them to the **target directory** (the user's home directory `~`).

## How chezmoi works

chezmoi manages dotfiles by maintaining a declarative source of truth in this repo. The workflow:

1. **Edit** — modify files in the source directory (this repo) or use `chezmoi edit`
2. **Apply** — run `chezmoi apply` to sync changes to `~`
3. **Update** — on other machines, `chezmoi update` pulls and applies the latest state

chezmoi never modifies the source directory during `apply`; it only writes to the target.

## Source state attributes (prefixes and suffixes)

File and directory names in this repo use special **prefixes** and **suffixes** that chezmoi interprets. They do not appear in the target path.

### Common prefixes

| Prefix | Meaning |
| --- | --- |
| `dot_` | Replaced with a leading `.` in the target (e.g. `dot_gitconfig` → `~/.gitconfig`) |
| `private_` | Sets file/directory permissions to remove group and world access |
| `readonly_` | Removes write permissions on the target |
| `empty_` | Keeps the file even if it is empty (by default chezmoi removes empty files) |
| `executable_` | Adds executable permission to the target file |
| `encrypted_` | The source file is encrypted; chezmoi decrypts it on apply |
| `exact_` | For directories: removes any child not managed by chezmoi |
| `create_` | Only creates the file if it doesn't already exist; never overwrites |
| `modify_` | Treats the source as a script that receives the existing target on stdin and outputs the new contents |
| `remove_` | Removes the target file, symlink, or empty directory |
| `symlink_` | Creates a symlink instead of a regular file |
| `run_` | Treats the file as a script to execute (used in `.chezmoiscripts/`) |
| `before_` / `after_` | Run order for scripts (before or after other updates) |
| `once_` / `onchange_` | Run the script only once, or only when its contents change |
| `external_` | Ignores attributes in child entries |
| `literal_` | Stops further prefix parsing (for filenames that collide with chezmoi prefixes) |

### Suffixes

| Suffix | Meaning |
| --- | --- |
| `.tmpl` | The file is a Go [text/template](https://pkg.go.dev/text/template); chezmoi renders it with template data before writing |
| `.literal` | Stops further suffix parsing |

Prefixes are order-sensitive and can be combined (e.g. `private_dot_ssh` → `~/.ssh` with restricted permissions). Target paths can always be inferred by stripping prefixes/suffixes per the rules above.

## Special chezmoi paths

| Path | Purpose |
| --- | --- |
| `.chezmoi.toml.tmpl` | Template for the chezmoi config file |
| `.chezmoiignore.tmpl` | Template listing files chezmoi should ignore |
| `.chezmoiscripts/` | Scripts chezmoi runs during apply |
| `.chezmoitemplates/` | Reusable template fragments included by other `.tmpl` files |

## Agent workflow

- Always run `chezmoi apply` and verify the latest changes after updating dotfiles

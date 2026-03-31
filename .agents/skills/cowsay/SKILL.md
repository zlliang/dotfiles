---
name: cowsay
description: Generate playful cowsay-style ASCII output for short messages. Use when a coding agent should format text as `cowsay`, demonstrate a `cowsay`-style command, or provide a simple terminal-friendly ASCII art reply.
---

# Cowsay

## Overview

Format short messages as `cowsay` output. Do not call `cowsay` directly. Prefer `uvx cowsay` when `uvx` is available; otherwise render a small manual fallback.

## Quick start

1. Check whether `uvx` exists
2. If it exists, run `uvx cowsay -t "<message>"`
3. If it does not exist, produce the ASCII output manually
4. Return the result in a fenced `text` block unless the user asked for a shell command only

## Output rules

- Keep messages short and wrap long text before the bubble becomes hard to read
- Preserve the user's wording unless they ask for rewriting
- Provide the exact shell command when the user asks how to run it locally, preferring `uvx cowsay`
- Use a manual fallback when `uvx` is unavailable or when command execution is unnecessary

## Fallback templates

```text
 _____________
< hello world >
 =============
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
```

```text
  _________________________________________________
 /                                                 \
| Lorem ipsum dolor sit amet, consectetur adipiscin |
| g elit. Mauris blandit rhoncus nibh. Mauris mi ma |
| uris, molestie vel metus sit amet, aliquam vulput |
| ate nibh.                                         |
 \                                                 /
  =================================================
                                                 \
                                                  \
                                                    ^__^
                                                    (oo)\_______
                                                    (__)\       )\/\
                                                        ||----w |
                                                        ||     ||
```

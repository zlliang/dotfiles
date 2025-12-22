# Global Agent Guidelines

This file is for AI coding agents (Claude Code, OpenAI Codex, Amp, etc.). I use agents for not only coding, but also daily scripting, managing my operating system, learning new topics, writing articles, and general problem-solving.

## About me

Call me Zilong (子龙). I'm a programmer passionate about web frontend and systems programming. My main languages are TypeScript and JavaScript; I also enjoy Python, Zig, and C.

## Environment

- **OS**: macOS (arm64), occasionally Linux VMs — always check the environment before running platform-specific commands
- **Shell**: fish (interactive), bash (scripting)
- **JS/TS tooling**: Node.js, pnpm, Bun

## Communication

- Be concise, accurate, well-structured, and insightful
- Infer my preferred language (English or Chinese) from my input, unless I specify otherwise
- Tone: calm, fluent, natural — intelligent and composed, never overly enthusiastic or mechanical
- Skip filler phrases like "Good question" or "You're absolutely right" — go straight to the point
- Be skeptical and precise — double-check reasoning, sources, and assumptions
- Treat our discussion as a collaboration toward accuracy; don't assume I'm correct

## Code style

Defer to project-specific configurations. No global preferences.

## Git commit messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

- Format: `<type>[optional scope]: <description>`
- Types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert`
- Use lowercase, imperative mood, no period at end
- Keep subject line under 72 characters
- Add `!` after type/scope for breaking changes (e.g., `feat!: ...`)

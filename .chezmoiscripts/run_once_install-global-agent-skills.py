#!/usr/bin/env -S uv run --quiet --script
"""chezmoi run_once script for installing global agent skills."""
# /// script
# ///

import subprocess


def run(cmd: list[str]) -> None:
    print(f"$ {' '.join(cmd)}")
    subprocess.run(cmd, check=True)


def installSkills(repo: str, skills: list[str]) -> None:
    run([
        "npx", "skills", "add", repo,
        "--skill", *skills, "-g", "-y",
        "-a", "amp", "codex", "claude-code",
    ])

def installBrew(packages: list[str]) -> None:
    run(["brew", "install", *packages])

def installPnpm(packages: list[str]) -> None:
    run(["pnpm", "add", "-g", *packages, "--dangerously-allow-all-builds"])


installSkills("github/awesome-copilot", ["gh-cli", "git-commit"])
installBrew(["gh"])

installSkills("vercel-labs/agent-browser", ["agent-browser"])
installPnpm(["agent-browser"])

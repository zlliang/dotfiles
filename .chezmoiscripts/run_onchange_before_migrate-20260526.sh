#!/bin/bash

rm -rf ~/.claude.json ~/.claude ~/.local/bin/claude ~/.local/share/claude ~/.local/state/claude ~/.cache/claude
rm -rf ~/.config/fish/functions/agent-prepare.fish
rm -rf ~/.agents

brew remove asciinema agg --force

#!/usr/bin/env bash

mise_path="$HOME/.local/bin/mise"
$mise_path install && $mise_path prune

#!/usr/bin/env bash
# Symlink every skill in ./skills into the personal skill folders for
# GitHub Copilot (VS Code + CLI) and Claude Code. Run from WSL, Linux, or macOS.
#
#   ./install.sh           # link into ~/.copilot/skills and ~/.claude/skills
#   ./install.sh --unlink  # remove the symlinks this script created
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
src="$repo_dir/skills"
targets=("$HOME/.copilot/skills" "$HOME/.claude/skills")
mode="${1:-link}"

if [ ! -d "$src" ]; then
  echo "No skills/ directory found at $src" >&2
  exit 1
fi

for target in "${targets[@]}"; do
  mkdir -p "$target"
  for skill_path in "$src"/*/; do
    [ -d "$skill_path" ] || continue
    name="$(basename "$skill_path")"
    link="$target/$name"

    if [ "$mode" = "--unlink" ]; then
      if [ -L "$link" ]; then
        rm "$link"
        echo "unlinked $link"
      fi
      continue
    fi

    if [ -e "$link" ] && [ ! -L "$link" ]; then
      echo "skip: $link exists and is not a symlink" >&2
      continue
    fi
    ln -sfn "$src/$name" "$link"
    echo "linked $link -> $src/$name"
  done
done

echo "Done. Reload VS Code and restart Claude Code / the Copilot CLI to pick up changes."

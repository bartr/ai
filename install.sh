#!/usr/bin/env bash
# Copy every skill in ./skills into the personal skill folders for
# GitHub Copilot (VS Code + CLI) and Claude Code. Run from WSL, Linux, or macOS.
#
#   ./install.sh             # copy into ~/.copilot/skills and ~/.claude/skills
#   ./install.sh --uninstall # remove the skill copies this script created
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
src="$repo_dir/skills"
targets=("$HOME/.copilot/skills" "$HOME/.claude/skills")
mode="${1:-install}"

if [ ! -d "$src" ]; then
  echo "No skills/ directory found at $src" >&2
  exit 1
fi

for target in "${targets[@]}"; do
  mkdir -p "$target"
  for skill_path in "$src"/*/; do
    [ -d "$skill_path" ] || continue
    name="$(basename "$skill_path")"
    dest="$target/$name"

    if [ "$mode" = "--uninstall" ]; then
      if [ -L "$dest" ]; then
        rm "$dest"
        echo "removed symlink $dest"
      elif [ -d "$dest" ]; then
        rm -rf "$dest"
        echo "removed $dest"
      fi
      continue
    fi

    if [ -e "$dest" ] && [ ! -d "$dest" ]; then
      echo "skip: $dest exists and is not a directory" >&2
      continue
    fi
    rm -rf "$dest"
    cp -R "$src/$name" "$dest"
    echo "copied $src/$name -> $dest"
  done
done

echo "Done. Reload VS Code and restart Claude Code / the Copilot CLI to pick up changes."

# AI Skills

A small collection of reusable **agent skills** for GitHub Copilot (VS Code + CLI) and Claude Code. Each skill lives under [`skills/`](skills/) and is copied into your personal skill folders by [`install.sh`](install.sh).

> **Platform:** the installer uses `$HOME` paths and standard Unix tooling, so it expects **WSL, Linux, or macOS**. It is not supported on native Windows (PowerShell/CMD).

## What's Included

| Skill | Description |
|-------|-------------|
| [`my-prd`](skills/my-prd/) | Generates a Product Requirements Document (PRD) from a brief idea or a notes file through a short interactive interview. Saves a Markdown PRD plus a resumable state file. |

## How It Works

`install.sh` copies every directory in `skills/` into both of these personal skill folders so the skills are picked up automatically:

- `~/.copilot/skills` — GitHub Copilot (VS Code and the Copilot CLI)
- `~/.claude/skills` — Claude Code

Because the skills are copied, edits you make in this repo are **not** reflected automatically — re-run `./install.sh` after changing a skill's contents.

## Getting Started

### Prerequisites

- WSL, Linux, or macOS with `bash`
- GitHub Copilot and/or Claude Code installed

### Install

From the repo root:

```bash
./install.sh
```

This creates `~/.copilot/skills` and `~/.claude/skills` if needed and copies each skill into them. Existing entries with the same name are replaced; a same-named path that is not a directory is skipped to avoid clobbering your own files.

Then **reload VS Code** and **restart Claude Code / the Copilot CLI** to pick up the new skills.

### Uninstall

To remove the skill copies this script created:

```bash
./install.sh --uninstall
```

## Using a Skill

Once installed, invoke a skill from your agent. For example, with the PRD Builder:

> Create a PRD for a feature that lets users export their data as CSV.

or point it at a notes file:

> Use the my-prd skill with my notes in `webv.md`.

The PRD Builder asks a few clarifying questions, writes the PRD to `docs/prd-[feature-name].md`, and saves a resumable session state file under `.prd-sessions/`.

## Adding a New Skill

1. Create a new folder under `skills/`, e.g. `skills/my-skill/`.
2. Add a `SKILL.md` with YAML front matter (`name`, `description`, optional `argument-hint`) describing when and how the skill should be used. See [`skills/my-prd/SKILL.md`](skills/my-prd/SKILL.md) as a template.
3. Add any supporting files the skill references (templates, question banks, schemas).
4. Run `./install.sh` to copy the new skill into your skill folders.

## Repository Structure

```
install.sh                  # copy installer (install / --uninstall)
skills/
  my-prd/
    SKILL.md                # skill definition and procedure
    questions.md            # interview question bank
    prd-template.md         # output PRD template
    state-schema.md         # resumable session state schema
```

# AI Skills — Repository Instructions

This repository is a collection of reusable **agent skills** for GitHub Copilot (VS Code + CLI) and Claude Code. Each skill lives under `skills/<skill-name>/` and is symlinked into personal skill folders by `install.sh`.

When working in this repo, follow the conventions below.

## Project layout

```
install.sh                  # symlink installer (link / --unlink)
skills/
  <skill-name>/
    SKILL.md                # required: skill definition with YAML front matter
    *.md                    # supporting files the skill references (templates, schemas, question banks)
```

- Every skill is a self-contained directory under `skills/`.
- Skill directory names are **kebab-case** (e.g. `my-prd`) and match the `name` in the skill's front matter.
- A skill references its supporting files by **relative path** (e.g. `./prd-template.md`) so it works regardless of where the directory is copied.

## Authoring a SKILL.md

Every skill must have a `SKILL.md` that starts with YAML front matter:

```yaml
---
name: kebab-case-name
description: 'One or more sentences. State what the skill produces AND when to use it (the trigger phrases / intents). Written so the agent can decide whether to load it.'
argument-hint: '[short hint of the expected argument]'   # optional
---
```

Conventions:

- `name` is required, kebab-case, and matches the directory name.
- `description` is required and should describe **both** the outcome and the triggering conditions ("Use when the user…"). This is what the agent matches against, so be explicit about intents.
- `argument-hint` is optional; include it when the skill expects an input such as a file path or feature name.
- After the front matter, use a clear body: a top-level `# Title`, then sections like **When to Use**, **Inputs**, **Outputs**, **Procedure**, and **Rules**.
- In **When to Use**, state explicitly when the skill should **not** apply, to prevent over-triggering.
- Keep procedures step-numbered and unambiguous; prefer explicit assumptions over blocking.

## Supporting files

- Put templates, schemas, and question banks in the skill's own directory and link to them with relative paths from `SKILL.md`.
- Do not reference files outside the skill directory — a skill must remain portable when copied.

## Installer conventions (`install.sh`)

- The installer copies each `skills/*/` directory into `~/.copilot/skills` and `~/.claude/skills`.
- It must stay POSIX-bash compatible and target WSL, Linux, and macOS only (`$HOME` paths) — do **not** add native-Windows/PowerShell logic.
- It must be idempotent: re-running replaces the copied skill directories cleanly, never clobbers a same-named path that is not a directory, and `--uninstall` removes only the skill copies it created.
- Keep `set -euo pipefail` and the install/`--uninstall` modes intact.

## Documentation

- When you add or rename a skill, update `README.md`: the **What's Included** table and the **Repository Structure** tree.
- Markdown style: sentence-case headings, fenced code blocks with a language, and relative links to in-repo files.

## Safety

- Never commit secrets, tokens, or credentials. Skills should read secrets from the environment at runtime, never embed them.
- Skills produce documents and guidance; they must not perform destructive actions on the user's behalf without confirmation.

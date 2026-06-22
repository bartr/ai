---
name: my-prd
description: 'Generate a Product Requirements Document (PRD) from a brief idea or a stream-of-consciousness notes file through a short interactive interview. Use when the user wants to create a PRD, turn a feature idea or notes into a spec, draft product requirements, or resume an in-progress PRD. Asks clarifying questions, fills gaps with stated assumptions, and saves a Markdown PRD plus a resumable state file.'
argument-hint: '[feature name or path to a notes/idea .md file]'
---

# PRD Builder

Turn a brief idea — or a stream-of-consciousness notes file — into a clear, actionable Product Requirements Document through a short interactive interview. Progress is saved to a state file so a PRD can be paused and resumed across sessions.

## When to Use

- The user asks to "create a PRD", "write product requirements", or "draft a spec".
- The user has a rough feature idea or a notes/brainstorm Markdown file to formalize.
- The user wants to resume a PRD started in an earlier session.

Do **not** use this skill to implement the feature. This skill produces a document only.

## Inputs

- A short feature description, **or** a path to a notes/idea Markdown file (e.g. `webv.md`).
- Optional: an existing state file from a previous session to resume from.

## Outputs

- **PRD:** Markdown at `docs/prd-[feature-name].md` (create the folder if needed). If the project has a different docs convention, follow it and tell the user where the file was written.
- **State file:** JSON at `.prd-sessions/[feature-name].state.json` capturing answered questions, processed references, and next actions. See [state schema](./state-schema.md).

`[feature-name]` is a kebab-case slug derived from the product/feature name.

## Procedure

1. **Resume check.** Look for an existing state file at `.prd-sessions/[feature-name].state.json`. If found, read it, summarize what was already answered, and continue from `nextActions` instead of starting over. If not found, start a new session.

2. **Ingest references.** If the user pointed to a notes/idea file, read it fully and extract candidate answers (problem, users, requirements, scope). Record each source under `referencesProcessed` in the state file. Treat the referenced file as the source of truth; cite it in the PRD's References section.

3. **Interview.** Ask the user the open questions from the [question bank](./questions.md), grouped by phase, **a few at a time** — never dump all questions at once. Skip questions already answered by the references. For anything still unknown after one reasonable follow-up, fill the gap with an explicit, logical assumption and mark it `TBD` in the PRD rather than blocking. Persist every answer to the state file as you go.

4. **Generate the PRD.** Populate the [PRD template](./prd-template.md) with the gathered answers. Keep requirements explicit and unambiguous; assume the primary reader is a Technical Program Manager. Mark unresolved items as `TBD` and list them as open questions.

5. **Save and report.** Write the PRD and update the state file (`currentPhase`, `questionsAsked`, `answeredQuestions`, `nextActions`). Tell the user the PRD path, the state-file path, and any remaining `TBD`s or open questions.

## Interview Phases

Run the interview in this order; each maps to PRD sections. Full prompts are in the [question bank](./questions.md).

| Phase | Captures | PRD sections |
|-------|----------|--------------|
| Context | Product name, problem, value, users | Overview, Purpose |
| Scope | In/out of scope, assumptions, constraints | Out of Scope, Purpose |
| Requirements | Functional requirements, API endpoints, user stories | Functional Requirements, API Endpoints, User Stories |
| Quality | Performance, security, scalability needs | Non-Functional Requirements |
| Acceptance | Done criteria, success signals | Acceptance Criteria |

## Rules

- Do **not** start implementing the PRD or writing feature code.
- Ask clarifying questions in small batches; respect answers already supplied by reference files.
- Prefer explicit assumptions over blocking; surface every assumption as `TBD` in the PRD.
- Always update the state file after each interview batch so the session is resumable.
- Use the exact section order in the [PRD template](./prd-template.md).

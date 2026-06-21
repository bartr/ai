# PRD State File Schema

The PRD Builder persists progress to `.prd-sessions/[feature-name].state.json` so a PRD can be paused and resumed across sessions. Read this file at the start of a session; write it after every interview batch.

## Schema

```json
{
  "prdFile": "docs/prds-[feature-name].md",
  "lastAccessed": "YYYY-MM-DDTHH:MM:SSZ",
  "currentPhase": "context | scope | requirements | quality | acceptance | validation | done",
  "questionsAsked": ["question-id", "..."],
  "answeredQuestions": {
    "question-id": "the user's answer or extracted value"
  },
  "referencesProcessed": [
    {
      "file": "path/to/notes.md",
      "status": "analyzed",
      "timestamp": "YYYY-MM-DDTHH:MM:SSZ",
      "keyFindings": "short summary of what was extracted",
      "integratedSections": ["overview", "functional-requirements"],
      "conflicts": []
    }
  ],
  "nextActions": ["what to do when this PRD is resumed"],
  "qualityChecks": ["goals-defined", "scope-clarified", "requirements-linked"],
  "userPreferences": {
    "detail-level": "brief | standard | comprehensive",
    "question-style": "structured | conversational"
  }
}
```

## Field Notes

- **currentPhase** — the interview phase in progress; matches the phases in `SKILL.md`.
- **questionsAsked** — ids from `references/questions.md` already presented (avoid re-asking).
- **answeredQuestions** — id → answer. Answers may come from the user or be extracted from a reference file.
- **referencesProcessed** — every notes/idea file ingested, with what was extracted and where it landed in the PRD.
- **nextActions** — the resume cue: the first thing to do when the session continues.
- **qualityChecks** — completion gates satisfied so far (see below).

## Quality Checks

Mark each once satisfied; all should be present before `currentPhase` becomes `done`:

- `goals-defined` — purpose and value are explicit.
- `scope-clarified` — in/out of scope are stated.
- `requirements-linked` — functional requirements trace to the problem/users.
- `acceptance-defined` — acceptance criteria are checkable.

## Resume Protocol

1. Read the state file.
2. Summarize `answeredQuestions` back to the user in one short paragraph.
3. Continue from `nextActions`; do not re-ask anything in `questionsAsked`.
4. If no state file exists, start a new session at `currentPhase: "context"`.

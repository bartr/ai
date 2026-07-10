---
title: "ADR Authoring Rubric"
description: "Self-critique checklist the ADR Author skill applies to a draft before files are emitted."
---

# ADR Authoring Rubric

Self-critique checklist the author applies to any draft before writing ADR files. Mechanical checks (frontmatter, required sections, citation counts) and the judgment checks below are all author self-review.

In autonomous mode, treat any failed required check as a blocking error: loop back to the failing step and fix it rather than writing the ADR. In interactive mode, surface failures to the user as warnings before proceeding.

## Categories

### 1. Evidence (Frame + Investigate)

- [ ] Context contains at least three verbatim block-quote citations from inputs (research files, plans, reviews, source files).
- [ ] Every Driver entry has a source citation (`source_path`, line range or commit) **or** is explicitly tagged `agent-inferred` with a one-line rationale.
- [ ] Every claim in Context that is not common knowledge maps to a `finding_id` in `research/`.

### 2. Traceability (Decide)

- [ ] Decision Outcome includes a driver × option matrix listing every Driver as a row and every considered option as a column.
- [ ] Every Constraint listed in Frame is explicitly cited by ID in Decision Outcome (either satisfied, accepted-tradeoff, or deferred).
- [ ] Every entry in `asr_triggers[]` has a corresponding entry in `success_criteria[]`.

### 3. Decomposition (Frame + Decide)

- [ ] Frame answered "what are the independent axes of this decision?" before options were generated.
- [ ] Chosen option does not silently bundle two or more independent axes; if it does, each axis is split out as a named sub-decision with its own Pros/Cons.

### 4. Balance (Decide)

- [ ] At least one rejected option has Pros that reference adversarial findings (`counter-evidence.md`).
- [ ] Adversarial pass output is present: agent argued for the strongest rejected option and against the chosen option.
- [ ] No rejected option is dismissed in a single sentence; each has at least one concrete Pro and one concrete Con.

### 5. Confirmation (Decide)

- [ ] At least one entry in `success_criteria[]` is **external** to the planner itself (CI signal, adoption metric, regression test, downstream artifact change).
- [ ] No success criterion relies solely on dogfooding the authoring path.
- [ ] Each success criterion has `metric`, `target`, and `measurement_window` populated.

### 6. Closure (Decide + Govern)

- [ ] `## Risks and Mitigations` section present with a table: `risk | likelihood | impact | mitigation | owner`.
- [ ] `## Rollback / Exit Strategy` section present with reversal steps and trigger conditions.
- [ ] `## Affected Components` section present in the ADR body (not only in compact-summary handoff).

### 7. Lifecycle (Frame + Govern)

- [ ] `proposed_date` set during Frame; `accepted_date` set during Govern; the two are distinct frontmatter fields.
- [ ] The `proposed → accepted` status transition is recorded with a timestamp when Govern accepts the decision.
- [ ] `related[]` populated with any related ADRs (or explicitly empty with rationale when none exist).

## Tier behavior

| Tier     | Required checks                                                                | Warnings only         |
|----------|--------------------------------------------------------------------------------|-----------------------|
| `draft`  | None (informational)                                                           | All                   |
| `guided` | Categories 1, 2, 7                                                             | Categories 3, 4, 5, 6 |
| `full`   | Categories 1, 2, 3, 4, 5, 6, 7                                                 | None                  |
| `deep`   | Categories 1, 2, 3, 4, 5, 6, 7 + web-research provenance on prior-art findings | None                  |

## Failure protocol

1. Identify the failing category and the specific item(s).
2. Map back to the originating phase (Frame / Investigate / Decide / Govern).
3. Re-enter that phase with the failure as targeted input; do not re-run earlier phases.
4. Re-run the rubric. Maximum two retries before escalating to the user under `full` and `deep`.

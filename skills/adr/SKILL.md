---
name: adr
description: 'Author high-quality Architecture Decision Records (ADRs) with a Y-Statement or MADR v4.0.0 template, at-least-two-options analysis, mandatory negative consequences, ASR (architecturally significant requirement) trigger evaluation, and atomic supersession lineage. Use when asked to write, draft, capture, refine, or supersede an ADR or architecture decision.'
license: CC-BY-4.0
metadata:
  authors: "microsoft/hve-core"
  baseline: "adr-author"
  spec_version: "1.0"
---

# Architecture Decision Record (ADR) Skill

## Overview

This skill produces and evolves Architecture Decision Records (ADRs): short, durable documents that capture one architectural decision, the options weighed, the choice made, and the consequences accepted. It carries the authoring rigor of the Microsoft HVE-Core `adr-author` skill in a single self-contained skill: two selectable output templates (compact Y-Statement and long-form MADR v4.0.0), an at-least-two-options rule, mandatory positive and negative consequences, ASR trigger evaluation, and atomic supersession lineage.

The bundled reference documents under `references/` hold the detailed knowledge; load a reference only when the active step needs it. Third-party templates and standards are cited by name only; the one exception is the MADR v4.0.0 template, which is reproduced verbatim under CC0-1.0 in `templates/madr-v4.md` (attribution in `references/standards-excerpts.md`).

## When to use

Use this skill when the request involves any of:

* Writing a new ADR or capturing an architecture decision that was just made.
* Documenting the rationale behind a technology, pattern, or design choice.
* Recording options considered and the reason one was chosen over the alternatives.
* Superseding, deprecating, or revisiting an earlier decision.
* Adopting a project's pre-existing ADR template as the output shape.

Trigger phrases include: "write an ADR", "record this decision", "architecture decision record", "why did we choose", "supersede ADR", "document the trade-offs".

## How this skill works

This is a **model-invoked skill**, not a separate agent. When relevant, the host agent (Copilot CLI, Copilot cloud agent, Claude Code, VS Code agent mode, and similar) loads this file into its own context and follows the guidance below using its normal tools. There is no separate persona, no blocking state machine, and no required session-state file.

The workflow below is a **recommended sequence with quality bars**, not a set of hard gates. Adapt it to the interaction mode:

* **Interactive mode (a human is present).** Ask focused clarifying questions before drafting, one topic at a time. Confirm the framing and the chosen option before writing the final record.
* **Autonomous mode (headless or one-shot).** Do not stall waiting for answers. Draft the ADR from the supplied context, mark every unknown as `TBD` with an explicit open question, and never invent drivers, constraints, or consequences the context does not support.

The single most important rule: **an ADR states a real trade-off.** A record with only one option, or with no documented downside, is not an ADR — it is a rationalization. Always weigh at least two options and always document negative consequences.

## Choosing entry mode and output template

**Entry mode** describes where the framing comes from; it does not change the output shape:

* **capture** — Interactive authoring driven by user answers.
* **from-planner-handoff** — Framing arrives pre-populated from an upstream planner (security, RAI, supply-chain). Confirm the framing before continuing.
* **adopt-template** — One-time setup that ingests a project's existing ADR template and emits both the first ADR and a committed `.adr-config.yml`.

**Output template** is an independent choice:

* **y-statement** — Compact, single-sentence record for low-stakes or reversible decisions. ASR triggers optional.
* **madr-v4** — Long-form MADR v4.0.0 record for architecturally significant decisions. ASR trigger evaluation required.

Any entry mode can target either output template. When unsure, ask whether the decision is architecturally significant (see the ASR catalog below); if yes, use `madr-v4`.

## ADR workflow

The workflow moves through three steps. Each step lists its objective, the references to consult, and a quality bar to satisfy before moving on (or to record as an open item in autonomous mode).

### 1. Frame

**Objective.** Bound the decision and capture who decides, why, and under what constraints.

* Write the **scope** in one or two sentences, bounded to a single decision.
* Record **decision-makers** as `deciders`, `consulted`, and `informed` (RACI-aligned). Prefer a role or team handle over a personal name. Never record personal contact details, secrets, credentials, or third-party or customer PII in any ADR field.
* List **drivers** (functional needs, business goals) and **constraints** (regulatory, platform, contractual, time).
* When the output template is `madr-v4`, evaluate **ASR triggers** against [asr-trigger-taxonomy.md](references/asr-trigger-taxonomy.md) and record the results. Use only the eight closed enum values.
* Decide the **diagram format** (ASCII or Mermaid) if the ADR will carry a diagram.

**Quality bar.** Scope, deciders, and drivers are recorded; ASR triggers are determined when the template is `madr-v4`; the framing is confirmed (interactive) or its unknowns are marked `TBD` (autonomous).

### 2. Decide

**Objective.** Weigh options, choose one, and state the consequences.

* Enumerate **at least two considered options**. A single-option ADR fails this bar.
* Score each option against the drivers and constraints from Frame; run an adversarial pass (argue for the strongest rejected option and against the chosen one) using [authoring-rubric.md](references/authoring-rubric.md).
* Name the **chosen option** and its **rationale**.
* Document **consequences**: positive, negative, and neutral. Negative consequences are mandatory.
* For the `y-statement` template, assemble the six-slot sentence from [y-statement.md](templates/y-statement.md). The Y-Statement is the entire Decide output; the full MADR options table is omitted.

**Quality bar.** At least two options, the chosen option, the rationale, and at least one negative consequence are recorded; every constraint from Frame is addressed (satisfied, traded off, or deferred).

### 3. Govern

**Objective.** Assemble, validate lineage, and write the final ADR. This is the only step that writes ADR files.

* Assemble frontmatter: for `madr-v4`, render from [madr-v4.md](templates/madr-v4.md) and merge [madr-v4-frontmatter-overlay.md](templates/madr-v4-frontmatter-overlay.md) on top to add the hve-core extension fields (`id`, `deciders`, `tags`, `supersedes`, `superseded-by`, `related`, `asr_triggers`) without editing the verbatim upstream template.
* Embed the diagram from [diagram-ascii.md](templates/diagram-ascii.md) or [diagram-mermaid.md](templates/diagram-mermaid.md) per the chosen format.
* Apply the six supersession rules in [lineage-rules.md](references/lineage-rules.md). When superseding, update both the predecessor and the successor in the same step (atomic lineage).
* Validate frontmatter against the field shapes and closed enums (status taxonomy, ASR triggers) before writing.
* Scan the draft for disclosure risk (personal emails, phone numbers, national identifiers, internal-only URLs on public repositories) and remove any findings before a durable write.
* Write the ADR to a stable location (for example, `docs/planning/adrs/{NNNN}-{slug}.md`), where `{NNNN}` is the next zero-padded identifier and `{slug}` is the slugified title.

**Quality bar.** Frontmatter passes the schema and enum checks; lineage updates are atomic when superseding; no disclosure-risk findings remain; the ADR is written to a stable, numbered path.

## Status taxonomy

ADR `status` is one of six closed values:

* `proposed` — under active drafting; not yet decided.
* `accepted` — decision adopted; current authority for its scope.
* `rejected` — considered and declined; retained for historical context.
* `deprecated` — no longer recommended but not yet replaced.
* `superseded` — replaced by a newer ADR via the lineage rules.
* `withdrawn` — proposal withdrawn before a decision.

## ASR trigger catalog

ASR (Architecturally Significant Requirement) triggers are evaluated only for the `madr-v4` template. The closed enum has eight values: `cost`, `performance`, `security`, `compliance`, `availability`, `scalability`, `maintainability`, `evolvability`. Do not introduce values outside this enum. The rubric and worked mappings are in [asr-trigger-taxonomy.md](references/asr-trigger-taxonomy.md).

## Supersession lineage (summary)

Full text and edge cases are in [lineage-rules.md](references/lineage-rules.md).

1. `supersedes` and `superseded-by` are each a scalar four-digit string or `null`.
2. Single-parent supersession — an ADR has at most one `superseded-by`.
3. Status transition — the superseding ADR becomes `accepted`; the superseded ADR becomes `superseded`.
4. Atomic update — both ADR files are updated in the same Govern step.
5. `last_decision_id` in `.adr-config.yml` advances only on new allocation and stays in sync with the highest identifier on disk.

## Adopt-template lifecycle

When the entry mode is `adopt-template`, replace Frame with a setup pass: **ingest** the user's existing ADR template, **normalize** it into the canonical frontmatter and section structure, **derive** the Frame and Decide question set from its required fields, **fill** the first ADR, then run **Govern**. When the adopted template lacks lineage fields, warn the user and require explicit confirmation before writing.

## Authoring conventions

* **One decision per ADR.** Split independent axes into separate records.
* **Identifiers.** Four-digit zero-padded `id` (for example, `0042`), scoped per project.
* **At least two options; mandatory negative consequences.** Enforced at the Decide bar.
* **Deciders over names.** Use role or team handles; never record PII, secrets, or credentials.
* **Verbatim MADR.** Never edit `templates/madr-v4.md`; add extension fields only through the overlay.
* **Closed enums.** `status` (six values) and `asr_triggers` (eight values) are closed; reject anything else.

## References

Load a reference only when the active step needs it.

* [standards-excerpts.md](references/standards-excerpts.md) - MADR v4.0.0 and Y-Statement attribution; status taxonomy; cite-only standards registry.
* [asr-trigger-taxonomy.md](references/asr-trigger-taxonomy.md) - Full ASR trigger taxonomy, rubric prompts, and examples for the eight enum values.
* [lineage-rules.md](references/lineage-rules.md) - Full text of the supersession rules with edge cases and worked examples.
* [authoring-rubric.md](references/authoring-rubric.md) - Self-critique checklist applied to a draft before writing.

## Templates

* [madr-v4.md](templates/madr-v4.md) - MADR v4.0.0 ADR template (verbatim, CC0-1.0). Used for `madr-v4` frontmatter assembly.
* [madr-v4-frontmatter-overlay.md](templates/madr-v4-frontmatter-overlay.md) - hve-core extension fields merged on top of the MADR frontmatter.
* [y-statement.md](templates/y-statement.md) - Six-slot Y-Statement formula for the `y-statement` template.
* [diagram-ascii.md](templates/diagram-ascii.md) - ASCII diagram block.
* [diagram-mermaid.md](templates/diagram-mermaid.md) - Mermaid diagram block.

## License and attribution

This skill is derived from the Microsoft HVE-Core `adr-author` skill and is licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). The MADR v4.0.0 template in `templates/madr-v4.md` is reproduced verbatim under [CC0-1.0](https://creativecommons.org/publicdomain/zero/1.0/); CC0 does not require attribution and it is recorded for transparency. Other third-party standards and frameworks (Y-Statement, ISO/IEC/IEEE, NIST, and others) are cited by name only through their references and are never reproduced here.

> Brought to you by microsoft/hve-core

---
name: requirements
description: 'Author high-quality Business Requirements Documents (BRDs) with measurable business goals, business rules, testable functional and non-functional requirements, an ISO/IEC/IEEE 29148 quality gate, ISO/IEC 25010 NFR coverage, ISTQB testability checks, author-maintained traceability, and a validated BRD-to-PRD handoff. Use when asked to write, draft, refine, review, or validate a BRD or business requirements.'
license: CC-BY-4.0
metadata:
  authors: "microsoft/hve-core"
  baseline: "requirements-author (BRD scope)"
  spec_version: "1.0"
---

# Business Requirements Document (BRD) Skill

## Overview

This skill produces and evolves Business Requirements Documents (BRDs): measurable, testable, and traceable statements of what a business needs and why, framed at the business tier before product design begins. It carries the requirements-engineering rigor of the Microsoft HVE-Core `requirements-author` skill (BRD scope) in a single self-contained skill: a canonical BRD template, SMART business goals, business rules, an ISO/IEC/IEEE 29148 quality gate, an ISO/IEC 25010 non-functional taxonomy, ISTQB testability screening, author-maintained traceability, and a versioned BRD-to-PRD handoff contract.

The bundled reference documents under `references/` hold the detailed knowledge; load a reference only when the active step needs it. Third-party standards are cited by name only and never reproduced. When the request is for product-level requirements rather than business requirements, use the companion `prd` skill; this skill produces the upstream BRD and the handoff that seeds it.

## When to use

Use this skill when the request involves any of:

* Writing a new BRD or business requirements document.
* Capturing business context, drivers, and stakeholder scope for an initiative.
* Turning a vague business need or initiative brief into concrete, testable requirements.
* Defining business goals, business rules, and success criteria before product design.
* Refining, reviewing, or quality-checking an existing BRD.
* Producing the BRD-to-PRD handoff that seeds downstream product requirements.

Trigger phrases include: "write a BRD", "business requirements", "capture business goals", "business rules", "requirements document", "review my BRD".

## How this skill works

This is a **model-invoked skill**, not a separate agent. When relevant, the host agent (Copilot CLI, Copilot cloud agent, Claude Code, VS Code agent mode, and similar) loads this file into its own context and follows the guidance below using its normal tools. There is no separate persona, no blocking state machine, and no required session-state file.

The workflow below is a **recommended sequence with quality bars**, not a set of hard gates. Adapt it to the interaction mode:

* **Interactive mode (a human is present).** Ask focused clarifying questions before drafting, one topic at a time. Confirm scope, stakeholders, and business goals before writing detailed requirements.
* **Autonomous mode (headless or one-shot).** Do not stall waiting for answers. Draft the BRD from the supplied context, mark every unknown as `TBD` with an explicit open question, and record assumptions in the Risks and Assumptions section. Never invent business goals, constraints, or stakeholders the user did not provide.

The single most important rule: **never write a requirement you cannot make measurable and testable.** Replace "improve", "efficient", "robust", or "user-friendly" with a quantified business threshold, or move the target to a non-functional requirement.

## BRD workflow

The workflow moves through three phases. Each phase lists its objective, the references to consult, and a quality bar to satisfy before moving on (or to record as an open item in autonomous mode).

### 1. Discover

**Objective.** Establish business context, stakeholder scope, and problem framing.

* Capture business context, drivers, imposed constraints, and expected outcomes.
* Identify stakeholders, decision owners, and review participants with [stakeholder-analysis.md](references/_shared/stakeholder-analysis.md) (Mendelow Power/Interest grid and RACI patterns).
* Define scope boundaries, assumptions, and dependency surfaces.
* Draft initial requirement candidates and seed traceability placeholders.

**Quality bar.** Scope is bounded and stakeholder ownership is explicit; core assumptions and constraints are documented; seed artifacts for Define are present and internally consistent. If not, gather that context first (interactive) or record it as the first open question (autonomous).

### 2. Define

**Objective.** Produce complete, testable, and traceable requirements content.

* Author full BRD content from [brd-full.md](templates/brd/brd-full.md), applying the field overlay in [brd-frontmatter-overlay.md](templates/brd/brd-frontmatter-overlay.md).
* Write business goals as `BG-###` (SMART, per [smart-rubric.md](references/_shared/smart-rubric.md)), business rules as `BR-###`, functional requirements as `FR-###`, non-functional requirements as `NFR-###`, constraints as `CON-###`, and acceptance criteria as `AC-###`.
* Classify non-functional requirements against the [ISO/IEC 25010 taxonomy](references/brd/iso-25010-nfr-taxonomy.md); every NFR states a measurable threshold.
* Shape acceptance criteria with [given-when-then.md](references/_shared/given-when-then.md) and screen requirements for testability with [istqb-testability.md](references/brd/istqb-testability.md).
* Assign identifiers with [id-schema.md](references/_shared/id-schema.md), route them with [traceability-naming.md](references/_shared/traceability-naming.md), and maintain the FR-to-AC and FR-to-BG matrix using [traceability-matrix.md](references/_shared/traceability-matrix.md).
* Score requirements against the ISO/IEC/IEEE 29148 gate in [iso-29148-quality-gate.md](references/brd/iso-29148-quality-gate.md) and the [requirements-quality-rubric.md](references/brd/requirements-quality-rubric.md).

**Quality bar.** Requirement content is complete, unambiguous, and testable; traceability satisfies the ID schema and naming policy; FR-to-AC coverage meets the active threshold or records a blocker; quality findings are generated and reviewed.

### 3. Govern

**Objective.** Finalize, approve, and publish the BRD, then emit the downstream handoff.

* Record version, owners, reviewers, and approval metadata in the frontmatter. Bump an approved BRD from a draft `0.x.y` version to `1.0.0` or higher.
* Resolve or disposition every remaining quality finding; record waivers where coverage gaps are accepted.
* Apply the supersession lineage rules below when issuing a replacement BRD.
* Produce the `BRD_TO_PRD_HANDOFF_V1` payload per [brd-to-prd-handoff-v1.md](references/brd/brd-to-prd-handoff-v1.md), applying its coverage and waiver validation rules (including zero-FR-coverage handling).

**Quality bar.** Approval status and required reviewers are recorded; version and lineage metadata are valid; the final quality report authorizes exit with no blocking findings; the handoff payload is published for the downstream PRD.

## BRD structure

The canonical document shape lives in [brd-full.md](templates/brd/brd-full.md). It covers: Executive Summary, Business Context, Stakeholders, Design Decisions, Business Goals, Business Rules, Functional Requirements, Non-Functional Requirements, Constraints, Process Models, Acceptance Criteria, Traceability Matrix, Risks and Assumptions, Glossary, Sign-Off, Disclaimer, and Document Metadata. Keep this order.

## Authoring conventions

* **Identifiers.** `BG-###` business goal, `BR-###` business rule, `FR-###` functional, `NFR-###` non-functional, `CON-###` constraint, `AC-###` acceptance. Rules in [id-schema.md](references/_shared/id-schema.md).
* **Business goals.** SMART, evaluated with [smart-rubric.md](references/_shared/smart-rubric.md); each goal is measurable with a target and time frame.
* **Acceptance criteria.** Given-When-Then behavioral triplets ([given-when-then.md](references/_shared/given-when-then.md)); screen for testability with [istqb-testability.md](references/brd/istqb-testability.md).
* **Non-functional requirements.** Categorize with the [ISO/IEC 25010 taxonomy](references/brd/iso-25010-nfr-taxonomy.md); every NFR states a measurable threshold.
* **Prioritization.** MoSCoW, per [prioritization-schemes.md](references/_shared/prioritization-schemes.md).
* **Traceability.** Author-maintained; keep FR-to-AC and FR-to-BG coverage current with [traceability-matrix.md](references/_shared/traceability-matrix.md).
* **Quality gate.** ISO/IEC/IEEE 29148 §5.2.5 characteristics scored per [iso-29148-quality-gate.md](references/brd/iso-29148-quality-gate.md); status taxonomy from [quality-rubric.md](references/_shared/quality-rubric.md).

## Status taxonomy

BRD `status` is one of four closed values:

* `draft` — actively authored or revised.
* `in-review` — under formal review and gate validation.
* `approved` — accepted for governed use.
* `superseded` — replaced by a newer approved BRD.

## Supersession lineage rules

* A BRD can supersede one or more earlier BRDs when scope is merged.
* A BRD can be superseded by only one approved successor version.
* Every supersession event records `supersedes` and `superseded_by` links.
* Supersession preserves historical artifacts for auditability.

## References

Load a reference only when the active step needs it.

### BRD references (`references/brd/`)

* [iso-29148-quality-gate.md](references/brd/iso-29148-quality-gate.md) - BRD scoring overlay for the ISO/IEC/IEEE 29148 individual-requirement characteristics.
* [iso-25010-nfr-taxonomy.md](references/brd/iso-25010-nfr-taxonomy.md) - ISO/IEC 25010 non-functional requirement categories.
* [istqb-testability.md](references/brd/istqb-testability.md) - ISTQB-aligned testability screening for requirements.
* [requirements-quality-rubric.md](references/brd/requirements-quality-rubric.md) - BRD quality rubric mechanics and per-record scoring.
* [brd-quality-formats.md](references/brd/brd-quality-formats.md) - BRD quality data-contract map.
* [brd-standard-findings-v1.md](references/brd/brd-standard-findings-v1.md) - `BRD_STANDARD_FINDINGS_V1` payload.
* [brd-quality-report-v1.md](references/brd/brd-quality-report-v1.md) - `BRD_QUALITY_REPORT_V1` payload.
* [brd-to-prd-handoff-v1.md](references/brd/brd-to-prd-handoff-v1.md) - `BRD_TO_PRD_HANDOFF_V1` payload and coverage/waiver rules.
* [handoff-payload-schema.md](references/brd/handoff-payload-schema.md) - Shared field conventions for the handoff payload.

### Shared references (`references/_shared/`)

* [requirements-definition.md](references/_shared/requirements-definition.md) - Requirement categories, canonical statement form, acceptance-criteria formats, quality dimensions.
* [id-schema.md](references/_shared/id-schema.md) - Canonical prefix and digit rules for identifiers.
* [traceability-naming.md](references/_shared/traceability-naming.md) - Identifier routing and traceability conventions.
* [traceability-matrix.md](references/_shared/traceability-matrix.md) - FR-to-AC and FR-to-BG matrix views and coverage formulas.
* [given-when-then.md](references/_shared/given-when-then.md) - Gherkin Given-When-Then acceptance form.
* [smart-rubric.md](references/_shared/smart-rubric.md) - SMART evaluation for business goals.
* [quality-rubric.md](references/_shared/quality-rubric.md) - Status taxonomy and gate decision rule.
* [prioritization-schemes.md](references/_shared/prioritization-schemes.md) - MoSCoW prioritization.
* [stakeholder-analysis.md](references/_shared/stakeholder-analysis.md) - Mendelow Power/Interest grid and RACI patterns.
* [design-decisions.md](references/_shared/design-decisions.md) - `DD-###` design decision registry.
* [process-modeling.md](references/_shared/process-modeling.md) - Process, decision, and structural diagram guidance.
* [diagram-format-selector.md](references/_shared/diagram-format-selector.md) - Mermaid vs. ASCII vs. none diagram selection.
* [standards-excerpts.md](references/_shared/standards-excerpts.md) - Cite-only registry of third-party standards (ISO, IIBA, PMI, ISTQB, NIST).

Additional shared scoring and pattern sheets are available under `references/_shared/` (atomicity checklist, ISO 29148 quality attributes, MoSCoW detail, Mendelow matrix, RACI patterns).

## Templates

* [brd-full.md](templates/brd/brd-full.md) - Canonical BRD template covering every section from Executive Summary through Document Metadata.
* [brd-frontmatter-overlay.md](templates/brd/brd-frontmatter-overlay.md) - BRD frontmatter field overlay.
* [diagram-ascii.md](templates/brd/diagram-ascii.md) - ASCII diagram block.
* [diagram-mermaid.md](templates/brd/diagram-mermaid.md) - Mermaid diagram block.

## Data contracts

Versioned payloads govern BRD quality assessment and the downstream handoff. Each `schema_version` is fixed; consumers fail fast on any other value, so the constants must not change.

| Contract          | `schema_version`           | Reference                                                                 |
|-------------------|----------------------------|---------------------------------------------------------------------------|
| Standard findings | `BRD_STANDARD_FINDINGS_V1` | [brd-standard-findings-v1.md](references/brd/brd-standard-findings-v1.md) |
| Quality report    | `BRD_QUALITY_REPORT_V1`    | [brd-quality-report-v1.md](references/brd/brd-quality-report-v1.md)       |
| BRD-to-PRD handoff| `BRD_TO_PRD_HANDOFF_V1`    | [brd-to-prd-handoff-v1.md](references/brd/brd-to-prd-handoff-v1.md)       |

## License and attribution

This skill is derived from the Microsoft HVE-Core `requirements-author` skill (BRD scope) and is licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). Third-party standards and frameworks (ISO/IEC/IEEE 29148, ISO/IEC 25010, ISTQB, SMART, MoSCoW, and others) are cited by name only through their references and are never reproduced here.

> Brought to you by microsoft/hve-core

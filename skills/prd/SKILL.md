---
name: prd
description: 'Author high-quality Product Requirements Documents (PRDs) with measurable goals, EARS/Given-When-Then acceptance criteria, an ISO/IEC/IEEE 29148-aligned quality bar, NIST SP 800-160 non-functional requirement coverage, and author-maintained traceability. Use when asked to write, draft, refine, review, or validate a PRD, product spec, or feature requirements.'
license: CC-BY-4.0
metadata:
  authors: "microsoft/hve-core"
  baseline: "requirements-author (PRD scope)"
  spec_version: "1.0"
---

# Product Requirements Document (PRD) Skill

## Overview

This skill produces and evolves Product Requirements Documents (PRDs): measurable, testable, and traceable specifications that bridge product vision and technical execution. It carries the requirements-engineering rigor of the Microsoft HVE-Core `requirements-author` skill (PRD scope) in a single self-contained skill: a canonical PRD template, EARS and Given-When-Then acceptance patterns, an ISO/IEC/IEEE 29148 quality bar, a NIST SP 800-160 non-functional requirement taxonomy, INVEST story screening, and author-maintained traceability from requirements to goals and acceptance criteria.

The bundled reference documents under `references/` hold the detailed knowledge; load a reference only when the active step needs it. Third-party standards are cited by name only and never reproduced.

## When to use

Use this skill when the request involves any of:

* Writing a new PRD, product spec, or feature requirements document.
* Turning a vague idea, brief, or business requirements document into concrete, testable requirements.
* Defining requirements for an AI-powered feature or system.
* Refining, reviewing, or quality-checking an existing PRD.
* Establishing a single source of truth for scope, success metrics, and acceptance criteria.

Trigger phrases include: "write a PRD", "document requirements", "spec this feature", "product requirements", "acceptance criteria", "review my PRD".

## How this skill works

This is a **model-invoked skill**, not a separate agent. When relevant, the host agent (Copilot CLI, Copilot cloud agent, Claude Code, VS Code agent mode, and similar) loads this file into its own context and follows the guidance below using its normal tools. There is no separate persona, no blocking state machine, and no required session-state file.

The workflow below is a **recommended sequence with quality bars**, not a set of hard gates. Adapt it to the interaction mode:

* **Interactive mode (a human is present).** Ask focused clarifying questions before drafting, one topic at a time. Confirm scope and goals before writing detailed requirements.
* **Autonomous mode (headless or one-shot).** Do not stall waiting for answers. Draft the PRD from the supplied context, mark every unknown as `TBD` with an explicit open question, and record assumptions in the Risks and Assumptions section. Never invent constraints, metrics, or a tech stack the user did not provide.

The single most important rule: **never write a requirement you cannot make measurable and testable.** Replace "fast", "easy", "secure", or "scalable" with a quantified threshold, or move the target to a non-functional requirement.

## PRD workflow

The workflow moves through seven steps. Each step lists its objective, the references to consult, and a quality bar to satisfy before moving on (or to record as an open item in autonomous mode).

### 1. Assess

**Objective.** Decide whether enough product context exists to start a PRD and derive a working title.

* Identify the initiative, the problem statement, and the primary target users.
* If an upstream business requirements document or handoff exists, ingest its scope, coverage, and constraints.
* Derive a meaningful kebab-case PRD name (for example, `expense-tracker-mobile`).

**Quality bar.** A kebab-case name can be derived, and the problem plus primary users are identified. If not, gather that context first (interactive) or record it as the first open question (autonomous).

### 2. Discover

**Objective.** Establish the title, scope, product goals, and success metrics.

* Explore the problem space with [product-discovery.md](references/prd/product-discovery.md) (persona and journey-map templates) and frame the minimum viable slice with [mvp-framing.md](references/prd/mvp-framing.md).
* Name target users, candidate success metrics using [metrics-frameworks.md](references/prd/metrics-frameworks.md) (JTBD, HEART, AARRR), and explicit non-goals.

**Quality bar.** Title and scope are explicit; primary users and candidate success metrics are named; in-scope and out-of-scope boundaries are recorded.

### 3. Create

**Objective.** Generate the PRD document from the canonical template.

* Create the PRD from [prd-full.md](templates/prd/prd-full.md), filling frontmatter and seeding the established scope, users, and goals.
* Keep the canonical section order so downstream tooling and reviewers can navigate predictably.

**Quality bar.** The PRD file exists, matches the canonical structure, and has scope and goals seeded.

### 4. Build

**Objective.** Gather detailed functional and non-functional requirements iteratively.

* Write functional requirements as `FR-###` items. Shape requirement sentences with [ears-acceptance.md](references/prd/ears-acceptance.md) and, where user-story framing helps, [connextra-template.md](references/prd/connextra-template.md). Screen stories with [invest.md](references/prd/invest.md).
* Write acceptance criteria as `AC-###` items using EARS phrasing or the Given-When-Then form in [given-when-then.md](references/_shared/given-when-then.md).
* Classify non-functional requirements as `NFR-###` items against the [NIST SP 800-160 taxonomy](references/prd/nist-800-160-nfr.md) buckets.
* Record product goals as `GOAL-###`, constraints as `CON-###`, and material choices as `DD-###` design decisions.
* Assign identifiers with [id-schema.md](references/_shared/id-schema.md) and route them with [traceability-naming.md](references/_shared/traceability-naming.md). Maintain the FR-to-AC and FR-to-GOAL matrix using [traceability-matrix.md](references/_shared/traceability-matrix.md).

**Quality bar.** Requirements are complete, singular, testable, and traceable; acceptance criteria follow EARS or Given-When-Then; every NFR is categorized; FR-to-AC and FR-to-GOAL coverage meet the PRD thresholds or record a waiver.

### 5. Integrate

**Objective.** Incorporate user-provided references, documents, and external materials.

* Reconcile incoming content with existing requirements and resolve conflicts.
* Link supporting evidence to the requirements and metrics it justifies.

**Quality bar.** Provided references are incorporated or explicitly deferred; source conflicts are resolved; evidence is linked.

### 6. Validate

**Objective.** Assess completeness and quality before approval.

* Score requirements against the nine ISO/IEC/IEEE 29148 §5.2.5 characteristics summarized in [requirements-definition.md](references/_shared/requirements-definition.md) and the status rubric in [quality-rubric.md](references/_shared/quality-rubric.md).
* Produce the quality payloads described in [prd-quality-formats.md](references/prd/prd-quality-formats.md): `PRD_STANDARD_FINDINGS_V1` and `PRD_QUALITY_REPORT_V1`.
* Resolve or disposition every finding; record waivers where coverage gaps are accepted.

**Quality bar.** Findings and the consolidated report are generated; coverage and quality thresholds are met or waived.

### 7. Finalize

**Objective.** Deliver the complete, actionable PRD.

* Record version, owners, reviewers, and approval metadata in the frontmatter.
* Confirm no unresolved blocking findings remain and publish the PRD for downstream implementation.

**Quality bar.** Approval status and reviewers are recorded; the final quality report shows no blocking findings; the PRD is ready to hand off.

## PRD structure

The canonical document shape lives in [prd-full.md](templates/prd/prd-full.md). It covers: Executive Summary, Product Context, Users and Personas, Design Decisions, Product Goals (SMART), Functional Requirements, Non-Functional Requirements (by NIST 800-160 bucket), Constraints, Process Models, Acceptance Criteria, Traceability Matrix, MVP and Release Framing, Success Metrics, Risks and Assumptions, Glossary, and Sign-Off. Keep this order.

## Authoring conventions

* **Identifiers.** `FR-###` functional, `AC-###` acceptance, `NFR-###` non-functional, `CON-###` constraint, `GOAL-###` goal, `DD-###` design decision. Rules in [id-schema.md](references/_shared/id-schema.md).
* **Acceptance criteria.** EARS sentence patterns ([ears-acceptance.md](references/prd/ears-acceptance.md)) for requirement statements; Given-When-Then ([given-when-then.md](references/_shared/given-when-then.md)) for behavioral triplets.
* **Non-functional requirements.** Categorize with the [NIST SP 800-160 taxonomy](references/prd/nist-800-160-nfr.md); every NFR states a measurable threshold.
* **Prioritization.** MoSCoW, per [prioritization-schemes.md](references/_shared/prioritization-schemes.md).
* **Traceability.** Author-maintained; keep FR-to-AC and FR-to-GOAL coverage current with [traceability-matrix.md](references/_shared/traceability-matrix.md).
* **Quality bar.** Nine ISO/IEC/IEEE 29148 §5.2.5 characteristics; status taxonomy `RISK` / `CAUTION` / `COVERED` / `NOT_APPLICABLE` from [quality-rubric.md](references/_shared/quality-rubric.md).

## References

Load a reference only when the active step needs it.

### PRD references (`references/prd/`)

* [product-discovery.md](references/prd/product-discovery.md) - Persona archetype and customer-journey-map templates; cite-only discovery frameworks (Opportunity Solution Tree, JTBD, Story Mapping).
* [mvp-framing.md](references/prd/mvp-framing.md) - Minimum viable scope and release-boundary framing.
* [metrics-frameworks.md](references/prd/metrics-frameworks.md) - JTBD, HEART, and AARRR success-metric frameworks.
* [ears-acceptance.md](references/prd/ears-acceptance.md) - The five EARS sentence patterns for requirements and acceptance criteria.
* [connextra-template.md](references/prd/connextra-template.md) - Connextra user-story template.
* [invest.md](references/prd/invest.md) - INVEST quality criteria for user stories.
* [nist-800-160-nfr.md](references/prd/nist-800-160-nfr.md) - Non-functional requirement taxonomy buckets.
* [prd-quality-formats.md](references/prd/prd-quality-formats.md) - PRD quality data-contract map.
* [prd-standard-findings-v1.md](references/prd/prd-standard-findings-v1.md) - `PRD_STANDARD_FINDINGS_V1` payload.
* [prd-quality-report-v1.md](references/prd/prd-quality-report-v1.md) - `PRD_QUALITY_REPORT_V1` payload.

### Shared references (`references/_shared/`)

* [requirements-definition.md](references/_shared/requirements-definition.md) - Requirement categories, canonical statement form, acceptance-criteria formats, quality dimensions.
* [id-schema.md](references/_shared/id-schema.md) - Canonical prefix and digit rules for identifiers.
* [traceability-naming.md](references/_shared/traceability-naming.md) - Identifier routing and traceability conventions.
* [traceability-matrix.md](references/_shared/traceability-matrix.md) - FR-to-AC and FR-to-GOAL matrix views and coverage formulas.
* [given-when-then.md](references/_shared/given-when-then.md) - Gherkin Given-When-Then acceptance form.
* [quality-rubric.md](references/_shared/quality-rubric.md) - Status taxonomy and gate decision rule.
* [smart-rubric.md](references/_shared/smart-rubric.md) - SMART evaluation for product goals.
* [prioritization-schemes.md](references/_shared/prioritization-schemes.md) - MoSCoW prioritization.
* [stakeholder-analysis.md](references/_shared/stakeholder-analysis.md) - Mendelow Power/Interest grid and RACI patterns.
* [design-decisions.md](references/_shared/design-decisions.md) - `DD-###` design decision registry.
* [process-modeling.md](references/_shared/process-modeling.md) - Process, decision, and structural diagram guidance.
* [diagram-format-selector.md](references/_shared/diagram-format-selector.md) - Mermaid vs. ASCII vs. none diagram selection.
* [standards-excerpts.md](references/_shared/standards-excerpts.md) - Cite-only registry of third-party standards (ISO, IIBA, PMI, ISTQB, NIST).

Additional shared scoring and pattern sheets are available under `references/_shared/` (atomicity checklist, ISO 29148 quality attributes, MoSCoW detail, Mendelow matrix, RACI patterns).

## Templates

* [prd-full.md](templates/prd/prd-full.md) - Canonical PRD template covering every section from Executive Summary through Sign-Off.

## Data contracts

Versioned payloads govern PRD quality assessment. Each `schema_version` is fixed; consumers fail fast on any other value, so the constants must not change.

| Contract          | `schema_version`           | Reference                                                                 |
|-------------------|----------------------------|---------------------------------------------------------------------------|
| Standard findings | `PRD_STANDARD_FINDINGS_V1` | [prd-standard-findings-v1.md](references/prd/prd-standard-findings-v1.md) |
| Quality report    | `PRD_QUALITY_REPORT_V1`    | [prd-quality-report-v1.md](references/prd/prd-quality-report-v1.md)       |

## License and attribution

This skill is derived from the Microsoft HVE-Core `requirements-author` skill (PRD scope) and is licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). Third-party standards and frameworks (EARS, ISO/IEC/IEEE, NIST, INVEST, JTBD, and others) are cited by name only through their references and are never reproduced here.

> Brought to you by microsoft/hve-core

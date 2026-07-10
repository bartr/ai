---
title: ADR Lineage Rules
description: Five supersession and lineage rules enforced by the adr-author skill validators (GP-06)
author: microsoft/hve-core
ms.date: 2026-05-02
ms.topic: reference
keywords:
  - adr
  - architecture-decision-record
  - lineage
  - supersession
  - project-planning
---

# ADR Lineage Rules (GP-06)

The five rules below govern supersession and lineage for ADRs authored with this skill. The author applies and checks all five during the Govern step. Treat any violation as a blocking error that must be resolved before the ADR is written.

## 1. Field Shape

`supersedes` is a scalar four-digit ADR identifier string (for example, `"0007"`) or `null`. `superseded-by` is likewise a scalar string or `null` (for example, `"0042"` or `null`). The validator rejects array values for either field, enforcing single-parent supersession (see Rule 2).

- Valid: `superseded-by: null`, `superseded-by: "0042"`, `supersedes: "0007"`.
- Invalid (counter-example): `superseded-by: ["0042", "0043"]` — rejected because supersession is single-parent (see Rule 2).

## 2. Single-Parent Supersession

Any given ADR has at most one `superseded-by`. Once an ADR is superseded, a second supersession attempt against the same predecessor fails validation. To replace a successor, supersede the successor itself; do not rewrite the predecessor's `superseded-by`.

- Valid: ADR-0007 → superseded-by ADR-0042. Later, ADR-0042 → superseded-by ADR-0099. ADR-0007 still points to ADR-0042; the chain is walked forward.
- Invalid (counter-example): rewriting ADR-0007's `superseded-by` from `ADR-0042` to `ADR-0099` to "skip" the intermediate decision — rejected.

## 3. Status Transition Rule

The superseding ADR's `status` becomes `accepted` (or remains `proposed` until the Govern phase accepts it). The superseded ADR's `status` becomes `superseded`. The validator rejects any other final-state combination (for example, marking the predecessor `deprecated` while pointing `superseded-by` at a successor).

- Valid: successor `status: accepted`, predecessor `status: superseded`.
- Invalid (counter-example): successor `status: rejected` paired with predecessor `status: superseded` — rejected because a rejected ADR cannot supersede anything.

## 4. Atomic Update Rule

Both ADR files MUST be modified in the same Govern step. Update both files together (predecessor `superseded-by` update and successor `supersedes` entry) or neither. Do not use a two-step "update predecessor later" flow.

- Valid: a single Govern invocation produces a commit (or staged change set) that contains edits to both files.
- Invalid (counter-example): writing the successor's `supersedes` now and "remembering" to update the predecessor in a follow-up session — rejected because the lineage allocator refuses partial application.

## 5. Single-Writer Rule for `last_decision_id`

Advance `last_decision_id` in `.adr-config.yml` only when allocating a new ADR identifier during Govern. Keep it in sync with the highest existing ADR identifier on disk; a mismatch indicates a missed or out-of-band edit and must be reconciled before writing another ADR.

- Valid: `last_decision_id` is updated only by the script during ADR allocation in the Govern phase.
- Invalid (counter-example): a contributor hand-edits `.adr-config.yml` to bump `last_decision_id` ahead of the next allocation — rejected on next validation pass.

## Validation Failure Modes

Check for the following five violation categories before writing an ADR. Each maps one-to-one with the rule above.

1. `LINEAGE_FIELD_SHAPE` — `superseded-by` or `supersedes` is not a scalar string or `null`.
2. `LINEAGE_MULTIPLE_PARENTS` — an ADR already has a non-null `superseded-by` and a second supersession is attempted against it.
3. `LINEAGE_BAD_STATUS_TRANSITION` — successor or predecessor ends in a status other than the permitted (`accepted`/`proposed`, `superseded`) combination.
4. `LINEAGE_ATOMIC_VIOLATION` — exactly one of the two affected ADR files was modified in the Govern invocation; both must be present in the change set.
5. `LINEAGE_LAST_DECISION_DRIFT` — `last_decision_id` in `.adr-config.yml` does not match the highest ADR identifier on disk, indicating a missed or out-of-band edit.

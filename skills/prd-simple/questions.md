# PRD Interview Question Bank

Ask these grouped by phase, **a few at a time**. Skip any question already answered by a reference file or a prior session (tracked in `questionsAsked`). For anything still unknown after one follow-up, record an explicit assumption and mark the field `TBD` in the PRD rather than blocking.

Each question has a stable `id` — store it in `questionsAsked` and key the answer in `answeredQuestions`.

## Phase 1 — Context

| id | Question |
|----|----------|
| `product-name` | What is the product or feature called? |
| `core-problem` | What problem does this solve, and for whom? |
| `solution-approach` | At a high level, how does it solve that problem? |
| `target-users` | Who are the primary users or personas? |
| `value` | What is the value or outcome if this succeeds? |

## Phase 2 — Scope

| id | Question |
|----|----------|
| `in-scope` | What is explicitly in scope for this release? |
| `out-of-scope` | What is explicitly out of scope? |
| `assumptions` | What assumptions are we making (platform, data, environment)? |
| `constraints` | Any hard constraints (tech, timeline, compliance, dependencies)? |

## Phase 3 — Requirements

| id | Question |
|----|----------|
| `functional-requirements` | What must the feature do? List the core capabilities. |
| `api-endpoints` | Does it expose an API? If so, which endpoints and what do they do? |
| `user-stories` | What are the key user stories (as a … I want … so that …)? |
| `priorities` | Which requirements are Must vs. Should vs. Could? |

## Phase 4 — Quality (Non-Functional)

| id | Question |
|----|----------|
| `performance` | Any performance or latency targets? |
| `security` | Any security, privacy, or PII considerations? |
| `scalability` | Expected scale, load, or availability needs? |
| `reliability` | Reliability/observability expectations (logging, metrics, health)? |

## Phase 5 — Acceptance

| id | Question |
|----|----------|
| `acceptance-criteria` | How will we know it is done? List checkable criteria. |
| `success-metrics` | What measurable signals indicate success after launch? |
| `owner-team` | Who owns the spec and who owns implementation? |
| `target-release` | What is the target release or timeframe? |

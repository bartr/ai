---
name: owasp-llm
description: 'OWASP Top 10 for LLM Applications (2025) knowledge base for identifying, assessing, and remediating security risks in large language model and generative AI systems. Use when reviewing, threat-modeling, or hardening an LLM or GenAI application, or when asked about prompt injection, sensitive information disclosure, excessive agency, system prompt leakage, or other LLM-specific risks.'
license: CC-BY-SA-4.0
metadata:
  authors: "OWASP LLM Applications Security Initiative"
  baseline: "owasp-llm"
  spec_version: "1.0"
  framework_revision: "1.0.0"
  content_based_on: "https://genai.owasp.org/resource/owasp-top-10-for-llm-applications-2025/"
---

# OWASP® Top 10 for LLM Applications (2025) Skill

## Overview

This skill encodes the **OWASP Top 10 for LLM Applications (2025)** as structured, agent-consumable reference documents for identifying, assessing, and remediating security risks in large language model and generative AI systems. Each of the ten vulnerability categories has its own reference file with detection signals and remediation guidance, indexed by a vulnerability catalog.

The bundled reference documents under `references/` hold the detailed knowledge; load a reference only when the active review needs it.

## When to use

Use this skill when the request involves any of:

* Security-reviewing or threat-modeling an LLM, RAG, or agentic application.
* Hardening a GenAI feature against prompt injection, data leakage, or tool misuse.
* Assessing an LLM system against a recognized industry risk framework.
* Triaging a suspected LLM-specific vulnerability and finding its remediation.
* Producing findings mapped to a stable OWASP LLM vulnerability identifier.

Trigger phrases include: "review this LLM app for security", "prompt injection", "is this agent safe", "LLM threat model", "OWASP LLM", "system prompt leakage", "excessive agency".

## How this skill works

This is a **model-invoked skill**, not a separate agent. When relevant, the host agent (Copilot CLI, Copilot cloud agent, Claude Code, VS Code agent mode, and similar) loads this file into its own context and consults the references below using its normal tools. There is no separate persona, no blocking state machine, and no required session-state file.

Start from [00-vulnerability-index.md](references/00-vulnerability-index.md) to locate the relevant categories, then load the specific vulnerability reference(s) for the risks in scope. When producing findings, cite the stable OWASP LLM identifier from the reference so results stay traceable to the framework.

## Normative references (LLM Top 10)

1. [00 Vulnerability Index](references/00-vulnerability-index.md) - Index of all vulnerability identifiers, categories, and cross-references.
2. [01 Prompt Injection](references/01-prompt-injection.md)
3. [02 Sensitive Information Disclosure](references/02-sensitive-information-disclosure.md)
4. [03 Supply Chain](references/03-supply-chain.md)
5. [04 Data and Model Poisoning](references/04-data-and-model-poisoning.md)
6. [05 Improper Output Handling](references/05-improper-output-handling.md)
7. [06 Excessive Agency](references/06-excessive-agency.md)
8. [07 System Prompt Leakage](references/07-system-prompt-leakage.md)
9. [08 Vector and Embedding Weaknesses](references/08-vector-and-embedding-weaknesses.md)
10. [09 Misinformation](references/09-misinformation.md)
11. [10 Unbounded Consumption](references/10-unbounded-consumption.md)

## Third-party attribution

Copyright © OWASP Foundation.
OWASP® Top 10 for LLM Applications (2025) content is derived from works by the
OWASP Foundation, licensed under CC BY-SA 4.0
(<https://creativecommons.org/licenses/by-sa/4.0/>).
Source: <https://genai.owasp.org/resource/owasp-top-10-for-llm-applications-2025/>
Modifications: Vulnerability descriptions restructured into agent-consumable reference
documents with added detection and remediation guidance.
OWASP® is a registered trademark of the OWASP Foundation. Use does not imply endorsement.

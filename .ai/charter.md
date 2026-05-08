# Artificial Cognition Charter

## Mission

Build a practical, auditable multi-agent cognition system for software work where competing AI agents improve each other through artifact exchange, tests, reviews, and explicit governance.

## First Operating Model

- Claude Cluster acts as the primary feature builder and architectural proposer.
- Codex Cluster acts as adversarial reviewer, tester, and alternate implementation proposer.
- GitHub stores shared memory, proposed changes, review history, and merge decisions.
- GitHub Actions acts as the neutral judge for repeatable checks.
- The human governor makes final merge, revise, reject, or split-task decisions.

## Core Rule

Agents must not exchange raw hidden reasoning. They may exchange only durable artifacts:

- Claims
- Evidence
- Assumptions
- Test results
- Counterarguments
- Decisions

These six artifact types live as required sections of every pull request body, not as separate files. The pull request template (`.github/PULL_REQUEST_TEMPLATE.md`) is their canonical form, and `scripts/validate-cognition-artifacts.ps1` enforces that each section contains substantive content before merge.

## Merge Principle

No change becomes stable cognition until it has:

- A clear claim
- Evidence or tests supporting the claim
- Recorded assumptions
- A counterargument or review pass
- A decision from the governor path

## Failure Principle

Conflicts and hallucinations are not hidden. They are logged, reviewed, and used to improve the protocol.

## Coordination vs. Reasoning

`.ai/agent-comms.md` is the coordination hub. It carries status, questions, proposals, and escalations only - the messages that do not fit a PR or a ledger entry. Substance and reasoning still flow through pull request artifacts and the conflict ledger. Treating the comms hub as a chat is itself a protocol violation.

## Where to Look

- `docs/protocol.md` for the end-to-end mission lifecycle.
- `docs/branch-protection.md` for the GitHub settings that make the protocol binding.
- `.ai/hallucination-risks.md` for the failure modes this charter exists to prevent.
- `.ai/agent-comms.md` for the coordination hub format and hygiene rules.

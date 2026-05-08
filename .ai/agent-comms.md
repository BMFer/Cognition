# Agent Communications Hub

This file is the coordination channel between cluster nodes. It is **not** a chat.

The cognition protocol's load-bearing rule is that the two clusters do not exchange raw hidden reasoning - they exchange durable artifacts. That rule still holds here. Substance, claims, counterarguments, and disagreements do **not** belong in this file. They live in pull request bodies (see `.github/PULL_REQUEST_TEMPLATE.md`) and, for unresolved disagreements, in `.ai/conflict-ledger.md`.

This file exists for the narrow class of messages that do not fit a PR or a ledger entry:

- **status** - "I am picking up mission #N" / "blocked on X" / "v0 hardening landed"
- **question** - a clarification needed before opening a PR; the answer either lands here as another entry or routes to a PR / issue link
- **proposal** - a suggestion that should become a mission issue; do not debate it here, file the issue
- **escalation** - flag for the human governor when an artifact-level conflict is unresolvable through the normal protocol

If you find yourself debating substance in this file, stop. That belongs in a PR or in the conflict ledger. The validator does not police this file's content; the discipline is on the agents.

## Message Format

Every entry is append-only and uses this exact structure. Keep `Content` to one or two sentences. If you need more, you need a PR or an issue, not a longer comms entry.

```text
Date:
From:        claude | codex | governor
To:          claude | codex | governor | all
Type:        status | question | proposal | escalation
Mission ref: #N (or "none")
Content:     <one or two sentences>
Follow-up:   <PR/issue link or "open">
```

## Hygiene Rules

- Append-only. Edits are for typo fixes, not rewrites.
- Resolve `Follow-up: open` entries by editing only that line to point at the resulting PR or issue. Do not rewrite the original message.
- A `question` that turns into a real disagreement gets a row in `.ai/conflict-ledger.md`. Cross-link from here, then leave the substance in the ledger.
- A `proposal` that gets accepted becomes a mission issue. Cross-link from here, do not expand the proposal in place.
- The post-merge `cognition-checkpoint.yml` workflow does not write to this file. Checkpoint stubs go to `decision-log.md` and `nap-checkpoints.md`.

## Messages

```text
Date: 2026-05-08
From: governor
To: all
Type: status
Mission ref: none
Content: v0 cognition protocol baseline is live. Claude landed the hardening pass and Codex reviewed and approved it. Use this hub for coordination only; reasoning still flows through PR artifacts.
Follow-up: open
```

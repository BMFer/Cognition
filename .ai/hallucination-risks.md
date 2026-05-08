# Hallucination Risks

This ledger tracks known ways the agent swarm may become unreliable.

## Active Risks

| Risk | Signal | Mitigation | Status |
| --- | --- | --- | --- |
| Agents invent repository state | Claims cite files, tests, or issues that do not exist | Require evidence paths, command output summaries, or links in the PR body | Active |
| Agents agree too quickly | Reviews repeat the builder's frame without challenge | Counterargument section is required and CI rejects placeholder dismissals like "N/A" | Active |
| Tests become symbolic | PRs include test claims without executable evidence | Test Results section requires at least one filled-in `Result:` line; CI status checks must pass | Active |
| Conflict disappears into summaries | Disagreements are resolved without a record | Log unresolved disagreements in `conflict-ledger.md` before merge | Active |
| Cluster identity is unverifiable | A PR could come from either cluster with no attribution | PR body must declare `**Cluster**: claude` or `**Cluster**: codex`; validator enforces it | Active |
| CODEOWNERS routing is suggestion, not rule | The opposite cluster is requested but not required as a reviewer | Branch protection must enable "Require review from Code Owners"; see `docs/branch-protection.md` | Active until branch protection is configured |
| Checkpoint stubs are ignored | The post-merge stub is commented but never landed in `.ai/` | Audit `decision-log.md` and `nap-checkpoints.md` against merged PRs each retro | Active |
| Comms hub becomes a chat | `agent-comms.md` entries debate substance instead of routing to PRs or the conflict ledger | Comms hub schema is enforced by convention; long or argumentative entries are flagged in retro and routed to their proper home | Active |
| Authorship spoofing via unauthenticated git metadata | Any actor with push access can set `user.name`, `user.email`, or a `Co-Authored-By` trailer to claim a cluster identity; nothing in default git verifies the author | Require signed commits on `main` (see `docs/branch-protection.md`) and register each cluster's signing key on its dedicated GitHub bot account. Text-based cluster attribution is a soft coordination signal, not a security boundary | Active until required signed commits are enabled |

## Review Prompt

Before merge, ask:

- What could be false here?
- What evidence would change the decision?
- Did either agent cite unverifiable state?
- Did the review produce a real counterargument?

# Cognition

Artificial Cognition Extensions is an experiment in raising AI-assisted engineering memory ceilings through artifact-based multi-agent cognition.

The project starts with two competing and cooperating agent clusters:

- Claude Cluster: builder, architect, refactor agent
- Codex Cluster: reviewer, tester, alternate implementation agent
- GitHub: shared memory, court record, merge gate
- Human Governor: final merge authority

The core rule is simple: agents do not share hidden reasoning. They share durable artifacts that can be inspected, tested, challenged, and merged.

## Protocol

Each meaningful reasoning cycle follows:

```text
Think -> commit -> summarize -> test -> review -> pause -> replan
```

Shared repo artifacts live under `.ai/`:

- `charter.md`: mission, values, and non-negotiable rules
- `decision-log.md`: stable decisions and rejected alternatives
- `hallucination-risks.md`: known failure modes and mitigations
- `agent-scoreboard.md`: lightweight agent performance record (manually maintained)
- `conflict-ledger.md`: disagreements that need resolution
- `nap-checkpoints.md`: per-merge system-state snapshots
- `agent-comms.md`: structured coordination hub between cluster nodes (status, questions, proposals, escalations - not a chat)

Per-PR artifacts live as required sections of the pull request body, not as separate files. The canonical form is `.github/PULL_REQUEST_TEMPLATE.md`; every PR must contain:

- `## Claim`
- `## Evidence`
- `## Assumptions`
- `## Test Results`
- `## Counterargument`
- `## Decision`

The cognition judge (`.github/workflows/cognition-judge.yml`) enforces this on every PR via `scripts/validate-cognition-artifacts.ps1`, which strips HTML comments, requires substantive content in each section, and fails CI on placeholder dismissals.

## SAFe Mapping

```text
Epic        = major system capability
Feature     = agent responsibility
Story       = GitHub issue
Sprint      = reasoning cycle
PI Planning = roadmap checkpoint
Scrum Sync  = agent status exchange
System Demo = working branch + test report
Retro       = failure/hallucination review
```

## First Build

Start with one Claude builder node, one Codex reviewer node, GitHub Actions as the neutral judge, and a human governor as final authority. Scale only after the conflict protocol produces useful records.

## Quickstart

1. Read `.ai/charter.md` for the non-negotiable rules.
2. Read `docs/protocol.md` for the end-to-end mission lifecycle.
3. Open a Mission issue using the `Mission issue` template.
4. The primary cluster opens a PR. The PR template carries the artifact bundle.
5. The adversary cluster reviews or opens a competing PR.
6. CI (`Cognition Judge`) validates the artifact bundle on every push to the PR.
7. The governor selects one of `Merge / Revise / Reject / Split task` and merges.
8. On merge, `Cognition Checkpoint` posts a paste-ready stub for `decision-log.md` and `nap-checkpoints.md`. Land it in the next PR's first commit.

To make the cross-cluster review rule binding, configure branch protection per `docs/branch-protection.md` and fill in real cluster identities in `.github/CODEOWNERS`.

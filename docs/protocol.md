# Cognition Protocol

This is the end-to-end flow of one mission through the system. Read this once before opening your first PR.

## Roles

- **Claude Cluster** — primary builder, architect, refactor proposer.
- **Codex Cluster** — adversarial reviewer, test author, alternate implementation proposer.
- **GitHub Actions** — neutral judge for repeatable mechanical checks.
- **Human Governor** — final merge / revise / reject / split-task authority.

The two clusters never share hidden reasoning. They exchange durable artifacts only, captured as sections of the PR body.

## Lifecycle of a Mission

1. **Mission issue.** A human opens an issue using the `Mission issue` template. The template requires a primary cluster, an adversary cluster, and an expected governor outcome.

2. **Primary branch.** The primary cluster opens a branch and a draft PR. The PR body must follow `.github/PULL_REQUEST_TEMPLATE.md` and declare its cluster identity at the top.

3. **Adversary branch or review.** The adversary cluster either:
   - opens a competing branch with its own PR (alternate implementation), or
   - posts a structured review on the primary PR with an explicit counterargument.

   Either way, the adversary's contribution lands in artifact form, not as hidden reasoning.

4. **Cognition judge.** On every PR, `cognition-judge.yml` runs `scripts/validate-cognition-artifacts.ps1`, which checks:
   - All `.ai/` artifact files exist.
   - The PR template still contains the six required sections.
   - The PR body declares a valid cluster.
   - Every artifact section has substantive content (HTML comments stripped).
   - Counterargument is not a placeholder dismissal.
   - Test Results contain at least one filled-in `Result:` line.
   - Exactly one governor decision is checked.

5. **Conflict logging.** When the two clusters disagree on a load-bearing point, that disagreement gets a row in `.ai/conflict-ledger.md` before the PR can merge. Conflicts are useful system memory; they are not hidden in summaries.

6. **Governor decision.** A human reviews the cluster artifacts and selects one of `Merge / Revise / Reject / Split task` in the PR body. CODEOWNERS and branch protection (see `docs/branch-protection.md`) enforce that the opposite cluster has reviewed first.

7. **Checkpoint stub.** On merge, `cognition-checkpoint.yml` posts a paste-ready stub for `.ai/decision-log.md` and `.ai/nap-checkpoints.md` as a PR comment. The next PR from either cluster lands those entries as its first commit. This is the "nap" - the moment cognition becomes stable repo state.

8. **Replan.** The next mission either consumes the new checkpoint as solved ground or builds directly on top of it. Open follow-ups from the decision log become candidates for the next mission issue.

## Artifact Discipline

The PR template's six sections are not paperwork. Each one exists because a specific failure mode killed a previous experiment:

| Section          | Failure it prevents                                                          |
|------------------|------------------------------------------------------------------------------|
| Claim            | Vague PRs that nobody can verify or contest.                                 |
| Evidence         | Confident assertions backed by nothing inspectable.                          |
| Assumptions      | Reviewers approving a change whose hidden premises they never saw.           |
| Test Results     | "Tested locally" claims that vanish when CI is asked to reproduce them.      |
| Counterargument  | Two agents collapsing into a shared bias instead of pressure-testing.        |
| Decision         | Merges with no explicit governor outcome, leaving intent ambiguous.          |

If a section is hard to fill, the PR is probably under-scoped or under-reviewed. The validator's job is to catch that before merge, not after.

## Coordination vs. Reasoning

Some messages do not fit a PR: "I am picking up mission #5", a clarifying question that does not yet warrant an issue, a proposal that should become a mission. These go in `.ai/agent-comms.md`, the structured coordination hub.

The hub is **not** a chat. It uses a fixed schema (date, from, to, type, mission ref, one-or-two-sentence content, follow-up). Reasoning, claims, evidence, and counterarguments still flow through PR artifacts. If a comms entry starts to debate substance, stop and route the message to a PR or to the conflict ledger.

## What to Read Next

- `.ai/charter.md` for the non-negotiable rules.
- `.ai/hallucination-risks.md` for the failure modes the protocol is built around.
- `.ai/agent-comms.md` for the coordination hub format and hygiene.
- `docs/branch-protection.md` for the GitHub settings that make CODEOWNERS binding.

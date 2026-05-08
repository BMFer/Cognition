# Branch Protection Settings

The cognition protocol depends on GitHub-side rules that this repo cannot configure on its own. Apply these settings to `main` (and any future long-lived branches) once the real cluster identities exist in `.github/CODEOWNERS`.

## Required Settings on `main`

Repository -> Settings -> Branches -> Branch protection rules -> Add rule.

Branch name pattern: `main`

Enable:

- **Require a pull request before merging.**
  - Required approvals: at least `1`.
  - **Dismiss stale pull request approvals when new commits are pushed.**
  - **Require review from Code Owners.** This is the rule that makes `.github/CODEOWNERS` binding - without it, CODEOWNERS is a suggestion.
- **Require status checks to pass before merging.**
  - **Require branches to be up to date before merging.**
  - Required check: `Validate cognition artifacts` (from `cognition-judge.yml`).
- **Require conversation resolution before merging.**
- **Require linear history.** Keeps the decision log and nap checkpoints aligned with one commit per stable cognition step.
- **Do not allow bypassing the above settings.** The governor still merges, but follows the same path as the clusters.

Optional but recommended:

- **Require signed commits**, once cluster identities have signing keys configured.
- **Restrict who can push to matching branches** to the governor and the cluster service accounts.

## How This Maps to the Protocol

| Protocol rule                                  | GitHub setting that enforces it                                           |
|------------------------------------------------|---------------------------------------------------------------------------|
| Opposite cluster must review.                  | Require review from Code Owners + CODEOWNERS lists both clusters.         |
| CI must pass before merge.                     | Require status checks + `Validate cognition artifacts` as required.       |
| One stable cognition step per merge.           | Require linear history.                                                   |
| Governor uses the same gate as the clusters.   | Do not allow bypassing.                                                   |
| New commits invalidate stale approvals.        | Dismiss stale pull request approvals when new commits are pushed.         |

If you cannot enable a setting yet (for example, because cluster identities do not exist), record the gap as an active risk in `.ai/hallucination-risks.md` so it is not silently forgotten.

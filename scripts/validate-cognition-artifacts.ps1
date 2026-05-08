$ErrorActionPreference = "Stop"

# Resolve repo root from the script location so this works regardless of CWD.
$repoRoot = Split-Path -Parent $PSScriptRoot
Set-Location -LiteralPath $repoRoot

$requiredFiles = @(
    ".ai/charter.md",
    ".ai/decision-log.md",
    ".ai/hallucination-risks.md",
    ".ai/agent-scoreboard.md",
    ".ai/conflict-ledger.md",
    ".ai/nap-checkpoints.md",
    ".ai/agent-comms.md",
    ".github/PULL_REQUEST_TEMPLATE.md",
    ".github/ISSUE_TEMPLATE/mission.yml"
)

$missingFiles = $requiredFiles | Where-Object { -not (Test-Path -LiteralPath $_) }
if ($missingFiles.Count -gt 0) {
    Write-Error ("Missing required cognition artifact(s): " + ($missingFiles -join ", "))
}

$requiredSections = @(
    "## Claim",
    "## Evidence",
    "## Assumptions",
    "## Test Results",
    "## Counterargument",
    "## Decision"
)

$prTemplate = Get-Content -Raw -LiteralPath ".github/PULL_REQUEST_TEMPLATE.md"
$missingSections = $requiredSections | Where-Object { $prTemplate -notmatch [regex]::Escape($_) }
if ($missingSections.Count -gt 0) {
    Write-Error ("PR template is missing required section(s): " + ($missingSections -join ", "))
}

# PR-body validation. Skipped (with a notice) if no PR body was supplied, e.g. on
# workflow_dispatch or push runs. Required when the workflow runs on pull_request.
$prBody = $env:COGNITION_PR_BODY

if ([string]::IsNullOrWhiteSpace($prBody)) {
    Write-Host "Static artifact validation passed. (No PR body supplied; skipping body checks.)"
    return
}

$body = $prBody -replace "`r`n", "`n"
$body = [regex]::Replace($body, "(?s)<!--.*?-->", "")

function Get-Section {
    param(
        [Parameter(Mandatory = $true)] [string] $Body,
        [Parameter(Mandatory = $true)] [string] $Heading
    )
    $escaped = [regex]::Escape($Heading)
    $pattern = "(?ms)^$escaped\s*$\n(.*?)(?=^##\s|\Z)"
    $m = [regex]::Match($Body, $pattern)
    if ($m.Success) {
        return $m.Groups[1].Value.Trim()
    }
    return ""
}

$failures = @()

# Cluster identity must be present and bound to one of the two known clusters.
$clusterMatch = [regex]::Match($body, "(?im)^\*\*Cluster\*\*\s*:\s*(claude|codex)\s*$")
if (-not $clusterMatch.Success) {
    $failures += "Cluster identity is missing or invalid. Add a line like '**Cluster**: claude' or '**Cluster**: codex' at the top of the PR body."
}

# Each artifact section must contain real content, not just stripped placeholders.
$minLengths = @{
    "## Claim"          = 20
    "## Evidence"       = 20
    "## Assumptions"    = 20
    "## Test Results"   = 30
    "## Counterargument"= 80
    "## Decision"       = 1
}

foreach ($heading in $requiredSections) {
    $section = Get-Section -Body $body -Heading $heading
    $needed  = $minLengths[$heading]
    if (-not $section -or $section.Length -lt $needed) {
        $failures += "Section '$heading' is empty or too short (need >= $needed chars after stripping comments and whitespace)."
    }
}

# Counterargument must be a real risk, not a placeholder dismissal.
$counterargument = Get-Section -Body $body -Heading "## Counterargument"
if ($counterargument -match "(?im)^\s*(n[/.]?a|none|nothing|no risk|nope|tbd)\.?\s*$") {
    $failures += "Counterargument is non-substantive ('$counterargument'). The protocol requires a real risk, not a dismissal."
}

# Test Results must include at least one filled-in 'Result:' line.
$testResults = Get-Section -Body $body -Heading "## Test Results"
if ($testResults -notmatch "(?im)^[ \t]*Result[ \t]*:[ \t]*\S") {
    $failures += "Test Results must include at least one filled-in 'Result:' line (e.g. 'Result: pass')."
}

# Exactly one governor outcome must be checked.
$decisionSection = Get-Section -Body $body -Heading "## Decision"
$checkedCount = ([regex]::Matches($decisionSection, "(?im)^\s*-\s*\[[xX]\]\s*(Merge|Revise|Reject|Split task)\s*$")).Count
if ($checkedCount -ne 1) {
    $failures += "Decision must have exactly one checked outcome (Merge, Revise, Reject, or Split task); found $checkedCount."
}

if ($failures.Count -gt 0) {
    $msg = "Cognition artifact validation failed:`n - " + ($failures -join "`n - ")
    Write-Error $msg
}

Write-Host "Cognition artifact validation passed. (Static + PR body checks.)"

$repoRoot = $PSScriptRoot
$skillsSource = Join-Path $repoRoot ".claude\skills"
$skillsTarget = Join-Path $env:USERPROFILE ".claude\skills"
$schemaSource = Join-Path $repoRoot "schemas"
$schemaTarget = Join-Path $env:USERPROFILE ".claude\schemas"

if (-not (Test-Path $skillsTarget)) {
    New-Item -ItemType Directory -Path $skillsTarget -Force | Out-Null
    Write-Host "Created directory $skillsTarget"
}

foreach ($skill in Get-ChildItem $skillsSource -Directory) {
    $target = Join-Path $skillsTarget $skill.Name
    if (Test-Path $target) {
        Write-Host "Skipping $($skill.Name) — already exists at $target"
    } else {
        New-Item -ItemType Junction -Path $target -Target $skill.FullName | Out-Null
        Write-Host "Linked $($skill.Name)"
    }
}

if (Test-Path $schemaTarget) {
    Write-Host "Skipping schemas — already exists at $schemaTarget"
} else {
    New-Item -ItemType Junction -Path $schemaTarget -Target $schemaSource | Out-Null
    Write-Host "Linked schemas"
}

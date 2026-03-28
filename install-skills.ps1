$skillsSource = Join-Path $PSScriptRoot ".claude\skills"
$skillsTarget = Join-Path $env:USERPROFILE ".claude\skills"

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

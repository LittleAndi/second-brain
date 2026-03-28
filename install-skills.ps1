$skillsSource = Join-Path $PSScriptRoot ".claude\skills"

foreach ($skill in Get-ChildItem $skillsSource -Directory) {
    $target = Join-Path $env:USERPROFILE ".claude\skills\$($skill.Name)"
    if (Test-Path $target) {
        Write-Host "Skipping $($skill.Name) — already exists at $target"
    } else {
        New-Item -ItemType Junction -Path $target -Target $skill.FullName | Out-Null
        Write-Host "Linked $($skill.Name)"
    }
}

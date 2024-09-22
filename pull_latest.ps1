# Pull latest Game
Write-Host "Starting to pull latest Game code..."
& .\pull_latest_game.ps1


# pull the YarnSpinner Respository. Print when it's pulled and display the latest commits.
try {
    Write-Host "Pull Latest YarnSpinner..."
    git subtree pull --prefix YarnSpinner https://github.com/YarnSpinnerTool/YarnSpinner-Godot.git develop --squash
} catch {
    if ($_.Exception.Message -match "Subtree is already at commit") {
        Write-Host "Subtree is already up to date, continuing..."
    } else {
        Write-Host "An error occurred: $_"
    }
}



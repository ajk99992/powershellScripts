$source = "C:\Users\ajay\OneDrive - Digital nGenuity\Documents"
$destination = "C:\Temp"
$csvPath = "C:\Temp\folders.csv"
$logFile = "C:\Temp\move_log.txt"

# Read CSV
$folders = Import-Csv -Path $csvPath
$totalFolders = $folders.Count
$count = 0

# Ensure destination exists
if (!(Test-Path -Path $destination)) {
    New-Item -ItemType Directory -Path $destination -Force
}

# Loop through each folder in the CSV and move it
foreach ($folder in $folders) {
    $count++
    $folderPath = "$source\$($folder.FolderName)"
    $destPath = "$destination\$($folder.FolderName)"

    # Update progress bar
    Write-Progress -Activity "Moving folders..." -Status "$count of $totalFolders moved" -PercentComplete (($count / $totalFolders) * 100)

    if (Test-Path -Path $folderPath) {
        Move-Item -Path $folderPath -Destination $destPath -Force -Verbose
        Add-Content -Path $logFile -Value "Moved: $($folder.FolderName) - $(Get-Date)"
    } else {
        Add-Content -Path $logFile -Value "Not Found: $($folder.FolderName) - $(Get-Date)"
        Write-Host "Not Found: $($folder.FolderName)" -ForegroundColor Red
    }
}

Write-Progress -Activity "Moving folders..." -Completed
Write-Host "Folder move completed!" -ForegroundColor Green

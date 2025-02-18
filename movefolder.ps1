$source = "C:\Users\ajay\OneDrive - Digital nGenuity\Documents"
$destination = "C:\Temp"
$csvPath = "C:\Temp\folders.csv"
$logFile = "C:\Temp\move_log.txt"

# Read CSV
$folders = Import-Csv -Path $csvPath

# Ensure destination exists
if (!(Test-Path -Path $destination)) {
    New-Item -ItemType Directory -Path $destination
}

# Loop through each folder in the CSV and move it
foreach ($folder in $folders) {
    $folderPath = "$source\$($folder.FolderName)"
    $destPath = "$destination\$($folder.FolderName)"
    
    if (Test-Path -Path $folderPath) {
        Move-Item -Path $folderPath -Destination $destPath -Force
        Add-Content -Path $logFile -Value "Moved: $($folder.FolderName) - $(Get-Date)"
    } else {
        Add-Content -Path $logFile -Value "Not Found: $($folder.FolderName) - $(Get-Date)"
    }
}

Write-Host "Folder move completed!"

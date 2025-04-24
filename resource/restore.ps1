Write-Host "Preparing to restore NVRAM..." -ForegroundColor Cyan

# Set source locations
$sourceFiles = @("nvram.txt", "SCEWIN_64.exe", "amifldrv64.sys", "amigendrv64.sys")
$localRoot = "$env:SystemDrive\"

# Check each local file and copy into working dir
foreach ($file in $sourceFiles) {
    $source = Join-Path $localRoot $file
    if (-not (Test-Path $source)) {
        Write-Host "Error: $file not found at $source" -ForegroundColor Red
        exit 1
    }
    Copy-Item $source -Destination ".\$file" -Force
}

# Download backup.bat from GitHub
$batUrl = "https://raw.githubusercontent.com/YukiWasTake/Bios-Script/main/resource/backup.bat"
Invoke-WebRequest -Uri $batUrl -OutFile ".\backup.bat"

# Launch batch file
Write-Host "Launching restore..." -ForegroundColor Yellow
Start-Process ".\backup.bat" -Wait

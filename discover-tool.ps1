Clear-Host

function Banner {

    Write-Host ""
    Write-Host "===================================================" -ForegroundColor Cyan
    Write-Host "         OnePlus Discover Manager - etacri         " -ForegroundColor Green
    Write-Host "===================================================" -ForegroundColor Cyan
    Write-Host ""
}

Banner

# Download platform-tools automatically
if (!(Test-Path ".\platform-tools")) {

    Write-Host "[INFO] ADB Platform Tools not found." -ForegroundColor Yellow
    Write-Host "[INFO] Downloading platform-tools..." -ForegroundColor Cyan
    Write-Host ""

    $url = "https://dl.google.com/android/repository/platform-tools-latest-windows.zip"
    $zip = "platform-tools.zip"

    try {

        Invoke-WebRequest -Uri $url -OutFile $zip

        Write-Host "[SUCCESS] Download completed." -ForegroundColor Green
        Write-Host "[INFO] Extracting files..." -ForegroundColor Cyan

        Expand-Archive -Path $zip -DestinationPath "." -Force

        Remove-Item $zip

        Write-Host "[SUCCESS] Platform-tools installed successfully." -ForegroundColor Green
    }

    catch {

        Write-Host "[ERROR] Failed to download platform-tools." -ForegroundColor Red
        exit
    }
}

# Verify adb exists
if (!(Test-Path ".\platform-tools\adb.exe")) {

    Write-Host "[ERROR] adb.exe not found." -ForegroundColor Red
    exit
}

Write-Host ""
Write-Host "[INFO] Starting ADB server..." -ForegroundColor Cyan

.\platform-tools\adb.exe start-server | Out-Null

Write-Host ""
Write-Host "[INFO] Checking device connection..." -ForegroundColor Cyan

# Wait for device
while ($true) {

    $devices = .\platform-tools\adb.exe devices

    if ($devices -match "unauthorized") {

        Write-Host ""
        Write-Host "[ACTION REQUIRED]" -ForegroundColor Yellow
        Write-Host "Please allow the USB debugging popup on your phone." -ForegroundColor Yellow
        Write-Host ""

        Start-Sleep -Seconds 3
        continue
    }

    if ($devices -match "`tdevice") {

        Write-Host ""
        Write-Host "[SUCCESS] Device connected successfully!" -ForegroundColor Green
        break
    }

    Write-Host ""
    Write-Host "[WAITING]" -ForegroundColor Yellow
    Write-Host "Connect your phone and enable USB debugging." -ForegroundColor Yellow
    Write-Host ""

    Start-Sleep -Seconds 3
}

# Show device model
$model = .\platform-tools\adb.exe shell getprop ro.product.model
$model = $model.Trim()

Write-Host ""
Write-Host "Connected Device: $model" -ForegroundColor Green

# Main menu loop
while ($true) {

    Write-Host ""
    Write-Host "================ MENU ================" -ForegroundColor Cyan
    Write-Host "1 - Disable Google Discover" -ForegroundColor White
    Write-Host "2 - Enable Google Discover" -ForegroundColor White
    Write-Host "3 - Replace Discover With Shelf" -ForegroundColor White
    Write-Host "4 - Reboot Device" -ForegroundColor White
    Write-Host "5 - Exit" -ForegroundColor White
    Write-Host "======================================" -ForegroundColor Cyan
    Write-Host ""

    $choice = Read-Host "Enter option"

    switch ($choice) {

        "1" {

            Write-Host ""
            Write-Host "[INFO] Disabling Google Discover..." -ForegroundColor Cyan

            .\platform-tools\adb.exe shell settings put secure assistant_screen_type 0
            .\platform-tools\adb.exe shell settings put secure assistant_screen_type_left_enable 0

            Write-Host ""
            Write-Host "[SUCCESS] Google Discover disabled." -ForegroundColor Green

            Write-Host ""
            Write-Host "[INFO] Rebooting device..." -ForegroundColor Cyan

            .\platform-tools\adb.exe reboot
        }

        "2" {

            Write-Host ""
            Write-Host "[INFO] Enabling Google Discover..." -ForegroundColor Cyan

            .\platform-tools\adb.exe shell settings put secure assistant_screen_type 2
            .\platform-tools\adb.exe shell settings put secure assistant_screen_type_left_enable 1

            Write-Host ""
            Write-Host "[SUCCESS] Google Discover enabled." -ForegroundColor Green

            Write-Host ""
            Write-Host "[INFO] Rebooting device..." -ForegroundColor Cyan

            .\platform-tools\adb.exe reboot
        }

        "3" {

            Write-Host ""
            Write-Host "[INFO] Replacing Discover with Shelf..." -ForegroundColor Cyan

            .\platform-tools\adb.exe shell settings put secure assistant_screen_type 1
            .\platform-tools\adb.exe shell settings put secure assistant_screen_type_left_enable 1

            Write-Host ""
            Write-Host "[SUCCESS] Shelf enabled." -ForegroundColor Green

            Write-Host ""
            Write-Host "[INFO] Rebooting device..." -ForegroundColor Cyan

            .\platform-tools\adb.exe reboot
        }

        "4" {

            Write-Host ""
            Write-Host "[INFO] Rebooting device..." -ForegroundColor Cyan

            .\platform-tools\adb.exe reboot
        }

        "5" {

            Write-Host ""
            Write-Host "Thank you for using OnePlus Discover Manager." -ForegroundColor Green
            Write-Host "Created by etacri" -ForegroundColor Cyan
            Write-Host ""

            exit
        }

        default {

            Write-Host ""
            Write-Host "[ERROR] Invalid option." -ForegroundColor Red
        }
    }
}
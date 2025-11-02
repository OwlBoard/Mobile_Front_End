# PowerShell Script to Setup Flutter Mobile App
# Run this from the Mobile_Front_End directory

Write-Host "🦉 Owlboard Mobile - Setup Script" -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan
Write-Host ""

# Check if Flutter is installed
Write-Host "Checking Flutter installation..." -ForegroundColor Yellow
$flutterVersion = flutter --version 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Flutter is not installed!" -ForegroundColor Red
    Write-Host "Please install Flutter from https://flutter.dev/docs/get-started/install" -ForegroundColor Yellow
    exit 1
}
Write-Host "✅ Flutter is installed" -ForegroundColor Green
Write-Host ""

# Install dependencies
Write-Host "Installing dependencies..." -ForegroundColor Yellow
flutter pub get
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Failed to install dependencies" -ForegroundColor Red
    exit 1
}
Write-Host "✅ Dependencies installed" -ForegroundColor Green
Write-Host ""

# Generate code
Write-Host "Generating model code..." -ForegroundColor Yellow
flutter pub run build_runner build --delete-conflicting-outputs
if ($LASTEXITCODE -ne 0) {
    Write-Host "⚠️  Code generation had some issues, but continuing..." -ForegroundColor Yellow
}
Write-Host "✅ Code generation complete" -ForegroundColor Green
Write-Host ""

# Copy images
Write-Host "Copying images from React app..." -ForegroundColor Yellow
$sourceDir = "..\Desktop_Front_End\src\styles\images"
$destDir = ".\assets\images"

if (Test-Path $sourceDir) {
    $images = @("whiteboard-bg.gif", "landscape.gif", "horse.png", "cat.gif")
    $copiedCount = 0
    
    foreach ($image in $images) {
        $sourcePath = Join-Path $sourceDir $image
        $destPath = Join-Path $destDir $image
        
        if (Test-Path $sourcePath) {
            Copy-Item -Path $sourcePath -Destination $destPath -Force
            Write-Host "  ✅ Copied: $image" -ForegroundColor Green
            $copiedCount++
        } else {
            Write-Host "  ⚠️  Missing: $image" -ForegroundColor Yellow
        }
    }
    
    Write-Host "✅ Copied $copiedCount images" -ForegroundColor Green
} else {
    Write-Host "⚠️  React app images directory not found" -ForegroundColor Yellow
    Write-Host "Please copy images manually to assets/images/" -ForegroundColor Yellow
}
Write-Host ""

# Check for connected devices
Write-Host "Checking for connected devices..." -ForegroundColor Yellow
flutter devices
Write-Host ""

Write-Host "==================================" -ForegroundColor Cyan
Write-Host "✅ Setup complete!" -ForegroundColor Green
Write-Host "==================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Configure API endpoints in lib/config/api_config.dart" -ForegroundColor White
Write-Host "2. Connect a device or start an emulator" -ForegroundColor White
Write-Host "3. Run: flutter run" -ForegroundColor White
Write-Host ""
Write-Host "For Android Emulator, use API URL: http://10.0.2.2:5000" -ForegroundColor Cyan
Write-Host "For iOS Simulator, use API URL: http://localhost:5000" -ForegroundColor Cyan
Write-Host ""
Write-Host "Happy coding! 🚀" -ForegroundColor Green

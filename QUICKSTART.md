# 🦉 Owlboard Mobile - Quick Start Guide

## ⚡ Quick Setup (5 minutes)

### 1. Install Flutter

**Windows:**
```powershell
# Download Flutter SDK from https://flutter.dev/docs/get-started/install/windows
# Extract to C:\flutter
# Add to PATH: C:\flutter\bin

flutter doctor
```

**macOS:**
```bash
brew install flutter
flutter doctor
```

### 2. Setup Project

```bash
cd Mobile_Front_End

# Install dependencies
flutter pub get

# Generate code
flutter pub run build_runner build --delete-conflicting-outputs
```

### 3. Add Images

Copy images from React app:
```powershell
# Windows PowerShell
Copy-Item ..\Desktop_Front_End\src\styles\images\* .\assets\images\
```

```bash
# macOS/Linux
cp ../Desktop_Front_End/src/styles/images/* ./assets/images/
```

### 4. Configure Backend

Edit `lib/config/api_config.dart`:
```dart
static const String userServiceUrl = 'http://10.0.2.2:5000'; // Android Emulator
// OR
static const String userServiceUrl = 'http://localhost:5000'; // iOS Simulator
```

> **Note:** Android emulator uses `10.0.2.2` to access host's localhost

### 5. Run App

```bash
# List available devices
flutter devices

# Run on connected device
flutter run

# Run on specific device
flutter run -d <device-id>
```

## 🎯 Testing Checklist

- [ ] App launches successfully
- [ ] Home screen displays with hero section
- [ ] Navigation bar shows (no login state)
- [ ] Click "Login" → Goes to login screen
- [ ] Enter credentials and login → Success
- [ ] Navigation bar updates (logged in state)
- [ ] Logout works
- [ ] Register new account works

## 🔧 Common Commands

```bash
# Hot reload (during development)
# Press 'r' in terminal

# Hot restart
# Press 'R' in terminal

# Run with specific flavor
flutter run --flavor dev

# Build APK
flutter build apk

# Clean build
flutter clean && flutter pub get

# Format code
flutter format lib/
```

## 📱 Emulator Setup

### Android

1. Open Android Studio
2. Tools → AVD Manager
3. Create Virtual Device
4. Choose device (Pixel 5)
5. Download system image (API 33)
6. Start emulator

### iOS (Mac only)

1. Open Xcode
2. Xcode → Open Developer Tool → Simulator
3. Choose device (iPhone 14)
4. Simulator will launch

## 🐛 Quick Fixes

**Problem:** `flutter: command not found`
- **Solution:** Add Flutter to PATH

**Problem:** API connection fails
- **Solution:** Use `10.0.2.2` for Android emulator, `localhost` for iOS

**Problem:** Images not showing
- **Solution:** Ensure images are in `assets/images/` and run `flutter pub get`

**Problem:** Build errors
- **Solution:** Run `flutter clean && flutter pub get`

**Problem:** Hot reload not working
- **Solution:** Press `R` for hot restart

## 🚀 Ready to Develop!

Your Flutter mobile app is ready. Start building! 🎉

**Next:** Check `README.md` for full documentation

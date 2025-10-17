# Owlboard Mobile App - Flutter

Complete conversion of the React TypeScript web app to Flutter mobile app.

## 🎉 What's Included

✅ **28+ files created**
✅ **Complete authentication system**
✅ **All API services**
✅ **State management with Provider**
✅ **7 screens (Home, Login, Register, Board, Profile, etc.)**
✅ **Custom theming matching React app**
✅ **Routing with go_router**
✅ **Local storage integration**

## ⚡ Quick Start

```powershell
# Run setup script
.\setup.ps1

# Or manually:
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
```

## 📚 Documentation

- **README.md** - Complete documentation
- **QUICKSTART.md** - 5-minute quick start
- **CONVERSION_SUMMARY.md** - Detailed conversion notes

## 🔧 Configuration

Edit `lib/config/api_config.dart`:

```dart
static const String userServiceUrl = 'http://10.0.2.2:5000'; // Android
static const String commentsServiceUrl = 'http://10.0.2.2:8001';
```

## 📱 Run

```bash
flutter run
```

## 🏗️ Architecture

```
lib/
├── main.dart              # Entry point
├── config/               # Configuration
├── models/               # Data models
├── providers/            # State management
├── screens/              # UI screens
├── services/             # API services
└── widgets/              # Reusable widgets
```

## 🚀 Features

- ✅ User authentication (login/register/logout)
- ✅ Home screen with hero section
- ✅ API integration (users & comments)
- ✅ Local storage for auth persistence
- ✅ Responsive design
- ✅ Dark/light theme
- 🚧 Canvas drawing (basic structure)
- 🚧 Board management (coming soon)
- 🚧 Real-time collaboration (planned)

## 📖 Learn More

See `README.md` for complete documentation.

---

**Built with Flutter** ❤️ **by Owlboard Team** 🦉

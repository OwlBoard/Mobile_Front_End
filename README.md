# Mobile_Front_End

Owlboard Mobile App - Flutter version of the React TypeScript web application.

## 🚀 Features

- ✅ **Complete UI Conversion** from React to Flutter
- ✅ **Authentication System** (Login/Register)
- ✅ **State Management** with Provider
- ✅ **API Integration** with User and Comments services
- ✅ **Routing** with go_router
- ✅ **Local Storage** with shared_preferences
- ✅ **Responsive Design** for mobile devices
- ✅ **Dark/Light Theme Support**

## 📁 Project Structure

```
Mobile_Front_End/
├── lib/
│   ├── main.dart                    # App entry point
│   ├── config/
│   │   ├── api_config.dart         # API configuration
│   │   ├── routes.dart             # App routing
│   │   └── theme.dart              # App theme
│   ├── models/
│   │   ├── user_model.dart         # User data models
│   │   ├── comment_model.dart      # Comment data models
│   │   └── board_model.dart        # Board/Shape data models
│   ├── providers/
│   │   ├── auth_provider.dart      # Authentication state
│   │   ├── comment_provider.dart   # Comments state
│   │   └── board_provider.dart     # Board/drawing state
│   ├── screens/
│   │   ├── home_screen.dart        # Home page
│   │   ├── login_screen.dart       # Login page
│   │   ├── register_screen.dart    # Registration page
│   │   ├── board_screen.dart       # Board/canvas page
│   │   ├── my_boards_screen.dart   # User's boards list
│   │   ├── paint_screen.dart       # Paint interface
│   │   ├── user_profile_screen.dart    # User profile
│   │   └── user_dashboards_screen.dart # Dashboards list
│   ├── services/
│   │   ├── user_api_service.dart       # User API calls
│   │   ├── comments_api_service.dart   # Comments API calls
│   │   └── storage_service.dart        # Local storage
│   └── widgets/
│       ├── top_bar_login.dart      # Navigation bar (logged in)
│       └── top_bar_no_login.dart   # Navigation bar (guest)
├── assets/
│   └── images/                     # Image assets
├── pubspec.yaml                    # Dependencies
└── README.md                       # This file
```

## 🔧 Setup & Installation

### Prerequisites

- **Flutter SDK** (3.0.0 or higher)
- **Dart SDK** (included with Flutter)
- **Android Studio** or **VS Code** with Flutter extensions
- **Android Emulator** or **Physical Device**

### Installation Steps

1. **Clone the repository:**
   ```bash
   cd Mobile_Front_End
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Generate model files (for JSON serialization):**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Copy images to assets:**
   Copy the images from your React app's `src/styles/images/` to `assets/images/`:
   - `whiteboard-bg.gif`
   - `landscape.gif`
   - `horse.png`
   - `cat.gif`

5. **Configure API endpoints:**
   Edit `lib/config/api_config.dart` or set environment variables:
   ```dart
   static const String userServiceUrl = 'http://your-backend-url:5000';
   static const String commentsServiceUrl = 'http://your-backend-url:8001';
   ```

6. **Run the app:**
   ```bash
   flutter run
   ```

## 🏃‍♂️ Running the App

### Development

```bash
# Run on connected device/emulator
flutter run

# Run with hot reload
flutter run --hot

# Run in release mode
flutter run --release
```

### Building

```bash
# Build APK (Android)
flutter build apk

# Build App Bundle (Android - for Play Store)
flutter build appbundle

# Build iOS (requires Mac)
flutter build ios
```

## 📱 Screens Overview

### Implemented Screens

| Screen | Status | Description |
|--------|--------|-------------|
| **HomeScreen** | ✅ Complete | Landing page with hero section and features |
| **LoginScreen** | ✅ Complete | User login with form validation |
| **RegisterScreen** | ✅ Complete | User registration |
| **BoardScreen** | 🚧 Basic | Whiteboard canvas (needs drawing implementation) |
| **MyBoardsScreen** | 🚧 Basic | List of user's boards |
| **UserProfileScreen** | 🚧 Basic | User profile view/edit |
| **PaintScreen** | 🚧 Basic | Paint interface |
| **UserDashboardsScreen** | 🚧 Basic | Dashboards overview |

## 🔄 React to Flutter Conversion

### Key Conversions

| React Concept | Flutter Equivalent |
|--------------|-------------------|
| `useState` | `setState()` or Provider |
| `useEffect` | `initState()`, `didChangeDependencies()` |
| `useContext` | `Provider.of()` or `Consumer` |
| `localStorage` | `SharedPreferences` |
| `axios/fetch` | `http` package or `dio` |
| React Router | `go_router` |
| CSS | `TextStyle`, `BoxDecoration`, Theme |
| Props | Constructor parameters |
| Hooks | Lifecycle methods or Providers |

### Example Conversion

**React:**
```typescript
const [isLoading, setIsLoading] = useState(false);

useEffect(() => {
  fetchData();
}, []);

const fetchData = async () => {
  setIsLoading(true);
  const data = await api.get('/users');
  setIsLoading(false);
};
```

**Flutter:**
```dart
bool _isLoading = false;

@override
void initState() {
  super.initState();
  _fetchData();
}

Future<void> _fetchData() async {
  setState(() => _isLoading = true);
  final data = await UserApiService.getAllUsers();
  setState(() => _isLoading = false);
}
```

## 🎨 Theming

The app uses a custom theme matching your React app's color scheme:

- **Primary Color:** `#2F3B52`
- **Dark Background:** `#0F172A`
- **Secondary Background:** `#1E293B`
- **Accent Color:** `#334155`

You can customize colors in `lib/config/theme.dart`.

## 🔌 API Integration

### User Service API

- Base URL: `http://localhost:5000/users`
- Endpoints:
  - `POST /register` - User registration
  - `POST /login` - User login
  - `GET /users` - Get all users
  - `GET /users/:id` - Get user by ID
  - `PUT /users/:id` - Update user
  - `DELETE /users/:id` - Delete user
  - `GET /users/:id/dashboards` - Get user's dashboards

### Comments Service API

- Base URL: `http://localhost:8001/comments`
- Endpoints:
  - `POST /dashboards/:id/users/:userId/comments` - Create comment
  - `GET /dashboards/:id` - Get dashboard comments
  - `PUT /:commentId` - Update comment
  - `DELETE /:commentId` - Delete comment

## 📦 Dependencies

### Main Dependencies

- `provider: ^6.1.1` - State management
- `go_router: ^12.1.3` - Routing
- `http: ^1.1.0` - HTTP requests
- `dio: ^5.4.0` - Advanced HTTP client
- `shared_preferences: ^2.2.2` - Local storage
- `json_annotation: ^4.8.1` - JSON serialization

### Dev Dependencies

- `build_runner: ^2.4.7` - Code generation
- `json_serializable: ^6.7.1` - JSON serialization generator
- `flutter_lints: ^3.0.0` - Linting rules

## 🛠️ Development Commands

```bash
# Get dependencies
flutter pub get

# Run code generation
flutter pub run build_runner build

# Watch for changes (auto-generate)
flutter pub run build_runner watch

# Clean build cache
flutter clean

# Analyze code
flutter analyze

# Run tests
flutter test

# Format code
flutter format lib/
```

## 🚀 Next Steps

### High Priority

1. **Implement Canvas Drawing**
   - Custom painter for shapes
   - Touch gestures for drawing
   - Tool implementation (pen, brush, shapes)

2. **Real-time Collaboration**
   - WebSocket integration
   - Sync drawing state
   - Multi-user cursor tracking

3. **Complete Board Management**
   - Create/delete boards
   - Share boards
   - Board permissions

### Medium Priority

4. **User Profile**
   - Profile editing
   - Avatar upload
   - Settings page

5. **Comments System**
   - Visual comment markers on canvas
   - Reply to comments
   - Comment threading

6. **Layers & History**
   - Layer management
   - Undo/redo functionality
   - History timeline

### Nice to Have

7. **Offline Support**
   - Local caching
   - Sync when online
   - Conflict resolution

8. **Export/Import**
   - Export to PNG/PDF
   - Import images
   - Save templates

9. **Animations & Polish**
   - Smooth transitions
   - Loading animations
   - Haptic feedback

## 🐛 Troubleshooting

### Common Issues

**Issue: API not connecting**
- Check if backend services are running
- Verify API URLs in `api_config.dart`
- Check emulator network settings

**Issue: Images not loading**
- Ensure images are in `assets/images/`
- Run `flutter pub get` after adding assets
- Check `pubspec.yaml` assets section

**Issue: Build errors**
- Run `flutter clean`
- Run `flutter pub get`
- Re-run code generation: `flutter pub run build_runner build --delete-conflicting-outputs`

**Issue: Hot reload not working**
- Restart the app (press `R` in terminal)
- Full restart (press `Shift + R`)
- Stop and re-run

## 📝 Code Generation

Some models use JSON serialization which requires code generation:

```bash
# Generate once
flutter pub run build_runner build

# Watch for changes
flutter pub run build_runner watch

# Clean and rebuild
flutter pub run build_runner build --delete-conflicting-outputs
```

This generates `.g.dart` files for models.

## 🌐 Backend Configuration

Make sure your backend services have CORS configured for mobile:

```python
# In your FastAPI backend
from fastapi.middleware.cors import CORSMiddleware

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # For development
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
```

## 📚 Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Provider Package](https://pub.dev/packages/provider)
- [go_router Package](https://pub.dev/packages/go_router)
- [Flutter Cookbook](https://docs.flutter.dev/cookbook)

## 🤝 Contributing

1. Create a feature branch
2. Make your changes
3. Test thoroughly
4. Submit a pull request

## 📄 License

Same license as the Desktop_Front_End project.

---

**Built with ❤️ using Flutter**

🦉 Owlboard Team

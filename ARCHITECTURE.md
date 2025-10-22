# Terminal Kadıköy - Project Architecture

## Overview
This project follows a clean, feature-based architecture with clear separation of concerns, making it scalable and maintainable.

## Project Structure

```
lib/
├── core/                          # Core application modules
│   ├── constants/                 # App-wide constants
│   │   └── app_constants.dart     # Constants for padding, animations, etc.
│   ├── localization/              # Internationalization (i18n)
│   │   ├── app_localizations.dart # Abstract localization class
│   │   ├── app_localizations_en.dart # English translations
│   │   ├── app_localizations_tr.dart # Turkish translations
│   │   └── app_localizations_delegate.dart # Localization delegate
│   ├── providers/                 # Global state providers
│   │   ├── locale_provider.dart   # Language state management
│   │   └── theme_provider.dart    # Theme state management
│   └── theme/                     # Theme configuration
│       ├── app_colors.dart        # Color definitions
│       └── app_theme.dart         # Theme configuration
│
├── features/                      # Feature-based modules
│   └── home/                      # Home feature example
│       ├── providers/             # Feature-specific state
│       │   └── counter_provider.dart
│       ├── screens/               # Feature screens
│       │   └── home_screen.dart
│       └── widgets/               # Feature-specific widgets
│           ├── counter_display.dart
│           └── language_selector.dart
│
├── shared/                        # Shared components
│   └── widgets/                   # Reusable widgets
│       ├── custom_button.dart
│       └── loading_indicator.dart
│
└── main.dart                      # App entry point
```

## Architecture Principles

### 1. Feature-Based Structure
- Each feature has its own folder under `features/`
- Features are self-contained with their own:
  - `screens/` - UI screens
  - `widgets/` - Feature-specific widgets
  - `providers/` - State management
  - `models/` - Data models (if needed)
  - `services/` - Business logic (if needed)

### 2. State Management
**Technology**: Flutter Riverpod 2.x

**Benefits**:
- Type-safe
- Compile-time safety
- Easy to test
- No boilerplate
- Better performance

**Usage Example**:
```dart
// Define a provider
final counterProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});

// Use in a widget
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    return Text('$count');
  }
}
```

### 3. Theme Management
- **Centralized Colors**: All colors defined in `AppColors` class
- **No Hard-coded Colors**: Always use colors from `AppColors`
- **Material 3**: Using Material Design 3
- **Dark Mode Ready**: Theme structure supports dark mode

**Usage Example**:
```dart
// ✅ Correct
Container(color: AppColors.primary)

// ❌ Wrong
Container(color: Colors.blue)
```

### 4. Localization (Multi-language)
- **Current Languages**: English (en), Turkish (tr)
- **Easy to Add More**: Just create new localization file
- **Type-safe**: Abstract class ensures all translations are implemented

**Adding a New Language**:
1. Create `app_localizations_[code].dart` in `core/localization/`
2. Extend `AppLocalizations` class
3. Implement all required getters
4. Add to `AppLocalizationsDelegate`
5. Add locale to `supportedLocales` in `main.dart`

**Usage Example**:
```dart
final localizations = AppLocalizations.of(context);
Text(localizations.welcomeMessage)
```

### 5. Constants Management
- **Centralized**: All constants in `AppConstants`
- **Categorized**: Colors, padding, animations, etc.
- **Reusable**: Use throughout the app

**Usage Example**:
```dart
// ✅ Correct
Padding(padding: EdgeInsets.all(AppConstants.paddingMedium))

// ❌ Wrong
Padding(padding: EdgeInsets.all(16.0))
```

## Code Guidelines

### 1. Widget Organization
```dart
class MyWidget extends ConsumerWidget {
  // 1. Constructor
  const MyWidget({super.key});
  
  // 2. Build method
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch providers
    final someState = ref.watch(someProvider);
    
    // Get localizations and theme
    final localizations = AppLocalizations.of(context);
    
    return Scaffold(...);
  }
  
  // 3. Helper methods (if any)
  void _someHelperMethod() {}
}
```

### 2. State Provider Pattern
```dart
// 1. Create a StateNotifier
class MyNotifier extends StateNotifier<MyState> {
  MyNotifier() : super(MyState.initial());
  
  void someAction() {
    state = state.copyWith(/* changes */);
  }
}

// 2. Create a provider
final myProvider = StateNotifierProvider<MyNotifier, MyState>((ref) {
  return MyNotifier();
});

// 3. Use in widgets
final myState = ref.watch(myProvider);
ref.read(myProvider.notifier).someAction();
```

### 3. Creating a New Feature
1. Create folder under `features/[feature_name]/`
2. Create subfolders: `screens/`, `widgets/`, `providers/`
3. Implement feature screens
4. Add feature-specific providers for state management
5. Create reusable widgets if needed
6. Add translations to localization files

## Key Technologies

- **Flutter**: ^3.9.2
- **flutter_riverpod**: ^2.6.1 (State Management)
- **intl**: ^0.19.0 (Localization)
- **flutter_localizations**: SDK (Built-in localization support)

## Best Practices

1. **Always use Riverpod for state management**
2. **Never hard-code colors** - use `AppColors`
3. **Never hard-code strings** - use localization
4. **Never hard-code spacing** - use `AppConstants`
5. **Keep features isolated** - minimize dependencies between features
6. **Use ConsumerWidget** for widgets that need state
7. **Use StatelessWidget** for static UI components
8. **Extract reusable widgets** to `shared/widgets/`
9. **Keep business logic in providers**, not in widgets
10. **Write descriptive comments** for complex logic

## Adding Dependencies

```bash
# Add to pubspec.yaml under dependencies
flutter pub add package_name

# For dev dependencies
flutter pub add --dev package_name

# Get packages
flutter pub get
```

## Running the App

```bash
# Get dependencies
flutter pub get

# Run on connected device
flutter run

# Run with specific device
flutter run -d [device_id]

# Build for production
flutter build apk      # Android
flutter build ios      # iOS
```

## Next Steps

1. Add more features following the same pattern
2. Add API integration (create `core/api/` folder)
3. Add local storage (use shared_preferences or hive)
4. Add navigation (use go_router)
5. Add form validation
6. Add error handling
7. Add logging
8. Add analytics

## Contributing

When adding new features:
1. Follow the existing folder structure
2. Use Riverpod for state management
3. Add translations for all user-facing strings
4. Use theme colors and constants
5. Write clean, documented code
6. Test your changes

## Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Riverpod Documentation](https://riverpod.dev)
- [Material Design 3](https://m3.material.io)
- [Flutter Localization](https://docs.flutter.dev/development/accessibility-and-localization/internationalization)


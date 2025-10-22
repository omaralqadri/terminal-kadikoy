# Terminal Kadıköy

A Flutter application built with clean architecture, state management, and multi-language support.

## Features

✅ **Clean Architecture** - Feature-based structure with clear separation of concerns  
✅ **State Management** - Riverpod for type-safe, reactive state management  
✅ **Multi-language Support** - English and Turkish (easily extensible)  
✅ **Theme Management** - Centralized colors and theming (Dark mode ready)  
✅ **Material Design 3** - Modern UI components  
✅ **No Hard-coded Values** - All colors, strings, and constants centralized  

## Project Structure

```
lib/
├── core/                    # Core modules (theme, localization, constants)
├── features/                # Feature-based modules
│   └── home/               # Example home feature
├── shared/                  # Shared widgets and utilities
└── main.dart               # App entry point
```

For detailed architecture documentation, see [ARCHITECTURE.md](ARCHITECTURE.md)

## Getting Started

### Prerequisites
- Flutter SDK ^3.9.2
- Dart SDK
- iOS Simulator / Android Emulator / Physical Device

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd terminal_kadikoy
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## Key Technologies

- **Flutter** - UI Framework
- **Riverpod** - State Management
- **Flutter Localizations** - Multi-language support
- **Material Design 3** - Design System

## Architecture Highlights

### State Management (Riverpod)
```dart
// Define provider
final counterProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});

// Use in widget
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    return Text('$count');
  }
}
```

### Localization
```dart
// Get translations
final localizations = AppLocalizations.of(context);
Text(localizations.welcomeMessage)

// Change language
ref.read(localeProvider.notifier).changeLocale('tr');
```

### Theme & Colors
```dart
// Always use centralized colors
Container(color: AppColors.primary)

// Access theme
Theme.of(context).textTheme.bodyLarge
```

## Adding a New Feature

1. Create folder under `lib/features/[feature_name]/`
2. Add subfolders: `screens/`, `widgets/`, `providers/`
3. Implement your feature
4. Add translations to localization files
5. Use `AppColors` for colors and `AppConstants` for spacing

## Contributing

Please read [ARCHITECTURE.md](ARCHITECTURE.md) for details on the project structure and coding standards.

## License

This project is licensed under the MIT License.

## Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Riverpod Documentation](https://riverpod.dev)
- [Material Design 3](https://m3.material.io)

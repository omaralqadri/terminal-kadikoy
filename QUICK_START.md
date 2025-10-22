# Quick Start Guide

## For New Developers

This guide will help you quickly understand and work with this project.

## 📁 File Structure at a Glance

```
lib/
├── core/
│   ├── constants/app_constants.dart      # App constants (padding, durations, etc.)
│   ├── localization/                     # Multi-language support
│   │   ├── app_localizations.dart       # Abstract class
│   │   ├── app_localizations_en.dart    # English translations
│   │   ├── app_localizations_tr.dart    # Turkish translations
│   │   └── app_localizations_delegate.dart
│   ├── providers/                        # Global providers
│   │   ├── locale_provider.dart         # Language state
│   │   └── theme_provider.dart          # Theme state
│   └── theme/
│       ├── app_colors.dart              # All app colors
│       └── app_theme.dart               # Theme configuration
├── features/
│   └── home/                            # Example feature
│       ├── providers/counter_provider.dart
│       ├── screens/home_screen.dart
│       └── widgets/
├── shared/
│   └── widgets/                         # Reusable widgets
└── main.dart                            # App entry point
```

## 🚀 Common Tasks

### 1. Add a New Color
**File**: `lib/core/theme/app_colors.dart`

```dart
class AppColors {
  static const Color myNewColor = Color(0xFF123456);
}
```

**Usage**:
```dart
Container(color: AppColors.myNewColor)
```

### 2. Add a New Translation String
**Step 1**: Add to abstract class (`app_localizations.dart`)
```dart
abstract class AppLocalizations {
  String get myNewString;
}
```

**Step 2**: Add English translation (`app_localizations_en.dart`)
```dart
@override
String get myNewString => 'My new string';
```

**Step 3**: Add Turkish translation (`app_localizations_tr.dart`)
```dart
@override
String get myNewString => 'Benim yeni stringim';
```

**Usage**:
```dart
final l10n = AppLocalizations.of(context);
Text(l10n.myNewString)
```

### 3. Create a New Feature

**Step 1**: Create folder structure
```bash
lib/features/my_feature/
├── providers/
├── screens/
├── widgets/
└── models/ (optional)
```

**Step 2**: Create a screen
```dart
// lib/features/my_feature/screens/my_feature_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyFeatureScreen extends ConsumerWidget {
  const MyFeatureScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Feature')),
      body: const Center(child: Text('Hello')),
    );
  }
}
```

**Step 3**: Create a provider (if needed)
```dart
// lib/features/my_feature/providers/my_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyNotifier extends StateNotifier<int> {
  MyNotifier() : super(0);
  
  void increment() => state++;
}

final myProvider = StateNotifierProvider<MyNotifier, int>((ref) {
  return MyNotifier();
});
```

**Step 4**: Use the provider
```dart
final value = ref.watch(myProvider);
ref.read(myProvider.notifier).increment();
```

### 4. Change Language Programmatically

```dart
// Get current locale
final locale = ref.watch(localeProvider);

// Change to Turkish
ref.read(localeProvider.notifier).changeLocale('tr');

// Change to English
ref.read(localeProvider.notifier).changeLocale('en');

// Toggle between languages
ref.read(localeProvider.notifier).toggleLocale();
```

### 5. Access Theme Colors in Widget

```dart
// Primary color
Theme.of(context).colorScheme.primary

// Or use AppColors directly
AppColors.primary

// Text styles
Theme.of(context).textTheme.headlineMedium
```

### 6. Create a Custom Widget

```dart
// lib/shared/widgets/my_custom_widget.dart
import 'package:flutter/material.dart';
import 'package:terminal_kadikoy/core/theme/app_colors.dart';
import 'package:terminal_kadikoy/core/constants/app_constants.dart';

class MyCustomWidget extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const MyCustomWidget({
    super.key,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.textOnPrimary,
          ),
        ),
      ),
    );
  }
}
```

## 🎨 Using Constants

### Padding/Spacing
```dart
// Instead of hardcoding:
Padding(padding: EdgeInsets.all(16.0))  // ❌

// Use constants:
Padding(padding: EdgeInsets.all(AppConstants.paddingMedium))  // ✅
```

### Border Radius
```dart
// Instead of hardcoding:
BorderRadius.circular(8.0)  // ❌

// Use constants:
BorderRadius.circular(AppConstants.radiusMedium)  // ✅
```

### Icon Sizes
```dart
Icon(Icons.home, size: AppConstants.iconMedium)  // ✅
```

## 🔄 State Management Patterns

### Simple State (Single Value)
```dart
final counterProvider = StateProvider<int>((ref) => 0);

// Use
final count = ref.watch(counterProvider);
ref.read(counterProvider.notifier).state++;
```

### Complex State (StateNotifier)
```dart
class TodosNotifier extends StateNotifier<List<Todo>> {
  TodosNotifier() : super([]);
  
  void addTodo(Todo todo) {
    state = [...state, todo];
  }
  
  void removeTodo(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }
}

final todosProvider = StateNotifierProvider<TodosNotifier, List<Todo>>((ref) {
  return TodosNotifier();
});
```

## 📱 Running the App

```bash
# Get dependencies
flutter pub get

# Run on connected device
flutter run

# Run with specific device
flutter devices
flutter run -d <device-id>

# Hot reload: Press 'r'
# Hot restart: Press 'R'
# Quit: Press 'q'
```

## 🐛 Debugging

```bash
# Check for issues
flutter analyze

# Format code
flutter format lib/

# Clean and rebuild
flutter clean
flutter pub get
flutter run
```

## 📝 Best Practices Checklist

Before committing your code, make sure:

- [ ] No hard-coded colors (use `AppColors`)
- [ ] No hard-coded strings (use localization)
- [ ] No hard-coded spacing (use `AppConstants`)
- [ ] Using `ConsumerWidget` for widgets that need state
- [ ] Added translations for both English and Turkish
- [ ] Following the feature-based folder structure
- [ ] Code is formatted (`flutter format`)
- [ ] No analyzer warnings (`flutter analyze`)

## 🆘 Common Issues

### Import not found
```bash
flutter clean
flutter pub get
```

### Hot reload not working
Press `R` for hot restart instead of `r`

### State not updating
Make sure you're using `ref.watch()` not `ref.read()` for reactive updates

### Colors not showing
Check if you imported `AppColors` and not using `Colors.*`

## 💡 Tips

1. **Use snippets**: Create code snippets in your IDE for common patterns
2. **Use ConsumerWidget**: Always use `ConsumerWidget` when you need providers
3. **Keep features isolated**: Minimize dependencies between features
4. **Extract widgets**: If a widget is used in multiple places, move it to `shared/widgets/`
5. **Use const**: Add `const` to widgets whenever possible for better performance

## 📚 Learn More

- Full architecture details: [ARCHITECTURE.md](ARCHITECTURE.md)
- Riverpod docs: https://riverpod.dev
- Flutter docs: https://flutter.dev


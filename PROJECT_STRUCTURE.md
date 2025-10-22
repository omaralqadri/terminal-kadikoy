# Project Structure Overview

## Complete File Structure

```
terminal_kadikoy/
│
├── lib/
│   ├── core/                                    # Core application infrastructure
│   │   ├── constants/
│   │   │   └── app_constants.dart              # App-wide constants (spacing, durations, etc.)
│   │   │
│   │   ├── localization/                       # Multi-language support (i18n)
│   │   │   ├── app_localizations.dart         # Abstract localization class
│   │   │   ├── app_localizations_en.dart      # English translations
│   │   │   ├── app_localizations_tr.dart      # Turkish translations
│   │   │   └── app_localizations_delegate.dart # Localization loader
│   │   │
│   │   ├── providers/                          # Global state providers
│   │   │   ├── locale_provider.dart           # Language selection state
│   │   │   └── theme_provider.dart            # Theme mode state (light/dark)
│   │   │
│   │   └── theme/                              # Theme configuration
│   │       ├── app_colors.dart                # Color palette definitions
│   │       └── app_theme.dart                 # Theme data (light & dark)
│   │
│   ├── features/                               # Feature-based modules
│   │   └── home/                              # Example: Home feature
│   │       ├── providers/
│   │       │   └── counter_provider.dart      # Counter state management
│   │       │
│   │       ├── screens/
│   │       │   └── home_screen.dart           # Home screen UI
│   │       │
│   │       └── widgets/                       # Feature-specific widgets
│   │           ├── counter_display.dart       # Counter display widget
│   │           └── language_selector.dart     # Language switcher
│   │
│   ├── shared/                                 # Shared/common components
│   │   └── widgets/                           # Reusable widgets across features
│   │       ├── custom_button.dart             # Custom button component
│   │       └── loading_indicator.dart         # Loading indicator widget
│   │
│   └── main.dart                              # Application entry point
│
├── assets/                                     # Static assets
│   ├── images/                                # Image files
│   └── localization/                          # Additional localization files
│
├── test/                                       # Unit & widget tests
│   └── widget_test.dart
│
├── android/                                    # Android platform code
├── ios/                                        # iOS platform code
│
├── pubspec.yaml                               # Dependencies & assets configuration
├── analysis_options.yaml                      # Linter rules
│
├── README.md                                  # Project overview
├── ARCHITECTURE.md                            # Detailed architecture documentation
├── QUICK_START.md                             # Quick reference guide
└── PROJECT_STRUCTURE.md                       # This file
```

## Module Responsibilities

### 📦 Core Module
**Purpose**: Contains app-wide infrastructure and configurations

#### Constants (`core/constants/`)
- App-wide constants (padding, spacing, durations)
- Configuration values
- Default settings

#### Localization (`core/localization/`)
- Multi-language support (English, Turkish)
- Translation management
- Language switching logic

#### Providers (`core/providers/`)
- Global state management
- App-level settings (language, theme)
- Cross-feature state

#### Theme (`core/theme/`)
- Color definitions (no hard-coded colors)
- Light and dark theme configurations
- Typography settings

---

### 🎯 Features Module
**Purpose**: Self-contained feature implementations

Each feature folder should contain:
- **providers/** - Feature-specific state management
- **screens/** - UI screens for the feature
- **widgets/** - Feature-specific reusable widgets
- **models/** - Data models (optional)
- **services/** - Business logic (optional)

**Example Structure**:
```
features/
└── authentication/
    ├── providers/
    │   └── auth_provider.dart
    ├── screens/
    │   ├── login_screen.dart
    │   └── register_screen.dart
    ├── widgets/
    │   └── auth_button.dart
    └── models/
        └── user_model.dart
```

---

### 🔄 Shared Module
**Purpose**: Reusable components across features

- **widgets/** - Common UI components used by multiple features
- **models/** - Shared data models
- **utils/** - Utility functions and helpers
- **extensions/** - Dart extensions

---

## Data Flow Architecture

```
┌─────────────────────────────────────────────────────────┐
│                      main.dart                          │
│                   (ProviderScope)                       │
└────────────────────┬────────────────────────────────────┘
                     │
          ┌──────────┼──────────┐
          │                     │
    ┌─────▼─────┐         ┌────▼────┐
    │  Locale   │         │  Theme  │
    │ Provider  │         │ Provider│
    └───────────┘         └─────────┘
                     │
          ┌──────────┼──────────┐
          │                     │
    ┌─────▼─────┐         ┌────▼────────┐
    │ Feature A │         │  Feature B  │
    │ Providers │         │  Providers  │
    └─────┬─────┘         └────┬────────┘
          │                    │
    ┌─────▼─────┐         ┌────▼────────┐
    │ Feature A │         │  Feature B  │
    │  Screens  │         │   Screens   │
    └───────────┘         └─────────────┘
```

## State Management Flow (Riverpod)

```
┌──────────────┐
│   Provider   │ ← Defines the state
└──────┬───────┘
       │
       ├─► StateNotifier (manages state)
       │
       └─► State (immutable data)
              │
              ▼
       ┌────────────┐
       │   Widget   │ ← Watches/reads provider
       └────────────┘
              │
              ▼
       ┌────────────┐
       │    UI      │ ← Renders based on state
       └────────────┘
```

## Localization Flow

```
┌──────────────────┐
│ Locale Provider  │ ← Current language selection
└────────┬─────────┘
         │
         ▼
┌────────────────────────┐
│ LocalizationDelegate   │ ← Loads correct translations
└────────┬───────────────┘
         │
    ┌────┼────┐
    │         │
┌───▼────┐ ┌─▼──────┐
│  EN    │ │   TR   │ ← Translation files
└────────┘ └────────┘
    │         │
    └────┬────┘
         │
         ▼
┌────────────────┐
│ AppLocalizations│ ← Used in widgets
└────────────────┘
         │
         ▼
┌────────────────┐
│   Widget UI    │ ← Displays translated text
└────────────────┘
```

## Theme Flow

```
┌──────────────────┐
│  Theme Provider  │ ← ThemeMode (light/dark)
└────────┬─────────┘
         │
         ▼
┌────────────────────┐
│    AppTheme        │ ← Theme configurations
└────────┬───────────┘
         │
    ┌────┼─────┐
    │          │
┌───▼────┐ ┌──▼───────┐
│ Light  │ │   Dark   │ ← Theme data
└────┬───┘ └────┬─────┘
     │          │
     └────┬─────┘
          │
          ▼
     ┌──────────┐
     │AppColors │ ← Color definitions
     └────┬─────┘
          │
          ▼
     ┌──────────┐
     │  Widget  │ ← Uses theme colors
     └──────────┘
```

## Best Practices

### ✅ DO
- Use feature-based organization
- Keep features self-contained
- Use Riverpod for state management
- Centralize colors in `AppColors`
- Centralize strings in localization files
- Use constants for spacing and sizes
- Write stateless/consumer widgets
- Keep business logic in providers

### ❌ DON'T
- Hard-code colors (use `AppColors`)
- Hard-code strings (use localization)
- Hard-code spacing (use `AppConstants`)
- Put business logic in widgets
- Create tightly coupled features
- Use setState (use Riverpod)
- Mix concerns (keep UI and logic separate)

## Adding New Components

### New Feature
1. Create `features/[feature_name]/`
2. Add `providers/`, `screens/`, `widgets/`
3. Implement feature logic
4. Add translations
5. Connect to navigation

### New Translation
1. Add to `app_localizations.dart`
2. Implement in `app_localizations_en.dart`
3. Implement in `app_localizations_tr.dart`
4. Use in widgets via `AppLocalizations.of(context)`

### New Color
1. Add to `AppColors` class
2. Use throughout app
3. Update both light and dark themes if needed

### New Shared Widget
1. Create in `shared/widgets/`
2. Use `AppColors` and `AppConstants`
3. Make it configurable via parameters
4. Document usage with examples

## File Naming Conventions

- **Files**: `snake_case.dart` (e.g., `home_screen.dart`)
- **Classes**: `PascalCase` (e.g., `HomeScreen`)
- **Variables**: `camelCase` (e.g., `counterValue`)
- **Constants**: `camelCase` (e.g., `paddingMedium`)
- **Providers**: `camelCase` with `Provider` suffix (e.g., `counterProvider`)

## Summary

This architecture provides:
- ✅ Clear separation of concerns
- ✅ Scalable feature-based structure
- ✅ Type-safe state management
- ✅ Multi-language support
- ✅ Centralized theming
- ✅ Easy to test
- ✅ Easy to maintain
- ✅ Easy to extend


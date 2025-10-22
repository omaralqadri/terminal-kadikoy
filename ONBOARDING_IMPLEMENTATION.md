# Onboarding Implementation Guide

## Overview

A complete 3-screen onboarding flow has been implemented with:
- State persistence (shows only once)
- Multi-language support (EN/TR)
- Reusable components
- API-ready architecture

## What Was Implemented

### 1. Enhanced Generic Button (`CustomButton`)
Location: `lib/shared/widgets/custom_button.dart`

**Features:**
- Fully rounded (pill shape) support
- Customizable colors, sizes, and border radius
- Optional icons
- Loading states
- Width and height control

**Usage Examples:**
```dart
// Fully rounded button (for onboarding)
CustomButton.rounded(
  text: 'Get Started',
  onPressed: () {},
  backgroundColor: Colors.blue,
  width: double.infinity,
  height: 56,
)

// Regular button with custom radius
CustomButton(
  text: 'Submit',
  onPressed: () {},
  borderRadius: 12,
  showIcon: false,
)
```

### 2. Data Model
Location: `lib/features/onboarding/models/onboarding_item.dart`

**API Ready Structure:**
```dart
class OnboardingItem {
  final String title;
  final String description;
  final String imageUrl;
  
  // fromJson and toJson methods included
}
```

### 3. Persistence Service
Location: `lib/core/services/onboarding_service.dart`

**Methods:**
- `isOnboardingCompleted()` - Check if user has seen onboarding
- `setOnboardingCompleted()` - Mark onboarding as complete
- `resetOnboarding()` - Reset for testing

**Testing:**
```dart
// To see onboarding again during development
await OnboardingService.resetOnboarding();
```

### 4. State Management (Riverpod)
Location: `lib/features/onboarding/providers/onboarding_provider.dart`

**Provider:**
```dart
final onboardingProvider = StateNotifierProvider<OnboardingNotifier, OnboardingState>((ref) {
  return OnboardingNotifier();
});
```

**State includes:**
- Current page index
- List of onboarding items
- Helper methods: `nextPage()`, `goToPage()`, `skipToEnd()`

### 5. UI Components

#### Page Indicator
Location: `lib/features/onboarding/widgets/page_indicator.dart`

Animated colored dots showing current progress.

#### Onboarding Screen
Location: `lib/features/onboarding/screens/onboarding_screen.dart`

**Features:**
- PageView with swipe support
- "Atla" (Skip) button on screens 1-2
- Colored theme per screen (Blue → Green → Orange)
- Smooth page transitions
- Terminal Kadıköy logo
- Illustration placeholders

### 6. Translations Added

**English & Turkish strings for:**
- `skip` - "Skip" / "Atla"
- `next` - "Continue" / "Devam"
- `getStarted` - "Get Started" / "Başlayalım"
- Screen 1: Title, description, button text
- Screen 2: Title, description, button text
- Screen 3: Title, description, button text

### 7. Main App Flow
Location: `lib/main.dart`

**Flow:**
1. App starts → `AppInitializer` checks onboarding status
2. If not completed → Show `OnboardingScreen`
3. If completed → Show `HomeScreen`
4. After completing onboarding → Mark as complete, navigate to home

## Current Onboarding Content

### Screen 1 (Blue Theme)
- **Title:** "Söğütlüçeşme'de açıldı."
- **Description:** "Açıklama metni" / "Description text"
- **Button:** "Devam" / "Continue"
- **Color:** #0000FF

### Screen 2 (Green Theme)
- **Title:** "Gastronomi ve Kültür Sanat Durağı" / "Gastronomy and Cultural Art Center"
- **Description:** "Açıklama metni" / "Description text"
- **Button:** "Devam" / "Continue"
- **Color:** #4CAF50

### Screen 3 (Orange Theme)
- **Title:** "İstanbul'un Yeni Buluşma Noktası" / "Istanbul's New Meeting Point"
- **Description:** "Açıklama metni" / "Description text"
- **Button:** "Başlayalım" / "Get Started"
- **Color:** #FF6F00

## Assets Required

Add these images to `assets/images/onboarding/`:
1. `onboarding_1.png` - Söğütlüçeşme illustration
2. `onboarding_2.png` - Gastronomy illustration
3. `onboarding_3.png` - Meeting point illustration

**Note:** Currently, placeholder icons show if images are missing. The onboarding flow works without images.

## How to Update Content

### Update Translations
1. Edit `lib/core/localization/app_localizations.dart` (add new getters if needed)
2. Update English: `lib/core/localization/app_localizations_en.dart`
3. Update Turkish: `lib/core/localization/app_localizations_tr.dart`

### Change Colors
Edit `lib/features/onboarding/screens/onboarding_screen.dart`:
```dart
final List<Color> _pageColors = [
  const Color(0xFF0000FF), // Screen 1
  const Color(0xFF4CAF50), // Screen 2
  const Color(0xFFFF6F00), // Screen 3
];
```

### Add/Remove Screens
Edit `lib/features/onboarding/providers/onboarding_provider.dart`:
```dart
items: const [
  OnboardingItem(...),
  OnboardingItem(...),
  // Add more screens here
],
```

## API Integration (When Ready)

### Current: Fixed Data
```dart
// In onboarding_provider.dart
static final OnboardingState _initialState = OnboardingState(
  currentPage: 0,
  items: const [
    OnboardingItem(title: '...', description: '...', imageUrl: '...'),
    // Fixed data
  ],
);
```

### Future: API Data
```dart
// 1. Create API service
class OnboardingApi {
  Future<List<OnboardingItem>> getOnboardingScreens() async {
    final response = await http.get(Uri.parse('your-api-url'));
    final List data = json.decode(response.body);
    return data.map((e) => OnboardingItem.fromJson(e)).toList();
  }
}

// 2. Update provider
class OnboardingNotifier extends StateNotifier<OnboardingState> {
  OnboardingNotifier() : super(_emptyState);
  
  Future<void> loadFromApi() async {
    final items = await OnboardingApi().getOnboardingScreens();
    state = state.copyWith(items: items);
  }
}

// 3. Load in UI
@override
void initState() {
  super.initState();
  ref.read(onboardingProvider.notifier).loadFromApi();
}
```

### Image Handling
When API provides image URLs:
```dart
// Change from Image.asset to Image.network
Image.network(
  item.imageUrl,
  fit: BoxFit.contain,
  loadingBuilder: (context, child, progress) {
    if (progress == null) return child;
    return CircularProgressIndicator();
  },
  errorBuilder: (context, error, stackTrace) {
    return PlaceholderWidget();
  },
)
```

## Testing

### Reset Onboarding
Add a debug button in settings (or run in code):
```dart
await OnboardingService.resetOnboarding();
// Then restart app to see onboarding again
```

### Test Different Languages
Use the language selector in the app to switch between EN/TR and verify translations.

### Test Navigation
1. First launch → Should show onboarding
2. Complete onboarding → Should navigate to home
3. Restart app → Should go directly to home
4. Skip button → Should go directly to home

## File Structure

```
lib/
├── core/
│   └── services/
│       └── onboarding_service.dart          # Persistence logic
├── features/
│   └── onboarding/
│       ├── models/
│       │   └── onboarding_item.dart         # Data model
│       ├── providers/
│       │   └── onboarding_provider.dart     # State management
│       ├── screens/
│       │   └── onboarding_screen.dart       # Main UI
│       └── widgets/
│           └── page_indicator.dart          # Progress dots
├── shared/
│   └── widgets/
│       └── custom_button.dart               # Enhanced button
└── main.dart                                # App initialization

assets/
└── images/
    └── onboarding/
        ├── onboarding_1.png                 # Add your images here
        ├── onboarding_2.png
        └── onboarding_3.png
```

## Dependencies Added

```yaml
dependencies:
  shared_preferences: ^2.2.2  # For persistence
```

## Key Features

✅ Shows only on first launch  
✅ Multi-language support (EN, TR)  
✅ Swipeable pages  
✅ Skip functionality  
✅ Colored themes per screen  
✅ Smooth animations  
✅ API-ready architecture  
✅ Reusable button component  
✅ Clean state management  
✅ Proper navigation flow  

## Common Issues

### Onboarding shows every time
Check if `OnboardingService.setOnboardingCompleted()` is being called after completion.

### Images not showing
1. Verify images are in `assets/images/onboarding/`
2. Check `pubspec.yaml` includes the assets path
3. Run `flutter pub get` after adding images

### Translations not working
Ensure you've implemented the getters in all three localization files.

## Next Steps

1. **Add actual images** to `assets/images/onboarding/`
2. **Update descriptions** with real content in localization files
3. **Test thoroughly** on both platforms (iOS/Android)
4. **Add analytics** to track onboarding completion rates
5. **Prepare for API integration** when backend is ready

## Support

For issues or questions:
- Check `ARCHITECTURE.md` for overall app structure
- Check `QUICK_START.md` for common tasks
- Review the code comments in each file


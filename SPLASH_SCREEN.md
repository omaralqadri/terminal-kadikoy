# Splash Screen Implementation

## Overview

The splash screen is the first screen users see when launching the app. It displays for 3 seconds before navigating to either the onboarding screens or the home screen.

## Implementation Details

### File Structure

```
lib/
└── features/
    └── splash/
        └── screens/
            └── splash_screen.dart

assets/
└── images/
    ├── splash.png               # Full-screen background
    └── terminal_logo_black.png  # Centered logo
```

### Visual Design

**Layout:**
```
┌─────────────────────────────────┐
│                                 │
│     (splash.png background)     │
│         covers full screen      │
│                                 │
│     [terminal_logo_black]       │  ← Centered
│                                 │
│                                 │
└─────────────────────────────────┘
```

**Components:**
- **Background:** `splash.png` - Full screen (BoxFit.cover)
- **Logo:** `terminal_logo_black` - Centered, 100px height
- **Duration:** 3 seconds

### Navigation Flow

```
App Launch
    ↓
Splash Screen (3 seconds)
    ↓
Check Onboarding Status
    ↓
    ├─→ Not Completed → OnboardingScreen
    └─→ Completed → HomeScreen
```

### Code Implementation

**Splash Screen Widget:**
- Uses `StatefulWidget` with `initState` to start timer
- `Future.delayed(Duration(seconds: 3))` for 3-second delay
- Checks `OnboardingService.isOnboardingCompleted()`
- Uses `Navigator.pushReplacement` to prevent back navigation to splash

**Key Features:**
1. **Full-screen background:** Uses `Stack` with `fit: StackFit.expand`
2. **Centered logo:** Uses `Center` widget
3. **Error handling:** Fallback to white background if images missing
4. **Smooth transition:** `pushReplacement` ensures no back button to splash

## Configuration

### Timing
To change the splash duration, modify the delay in `splash_screen.dart`:
```dart
await Future.delayed(const Duration(seconds: 3)); // Change seconds here
```

### Logo Size
To adjust logo size, modify the height in `splash_screen.dart`:
```dart
Image.asset(
  'assets/images/terminal_logo_black.png',
  height: 100, // Change height here
)
```

## Assets Required

Both images are already in `assets/images/`:
- ✅ `splash.png`
- ✅ `terminal_logo_black.png`

Both are referenced in `pubspec.yaml`.

## Testing

### First Launch (Onboarding Not Completed)
1. Run the app
2. Splash shows for 3 seconds
3. Navigate to OnboardingScreen
4. Complete onboarding

### Subsequent Launches (Onboarding Completed)
1. Run the app again
2. Splash shows for 3 seconds
3. Navigate directly to HomeScreen

### Reset for Testing
To see onboarding again:
```dart
await OnboardingService.resetOnboarding();
```

## App Entry Point

**Updated Flow in `main.dart`:**
```dart
MaterialApp(
  home: const SplashScreen(), // First screen shown
)
```

**Removed:**
- `AppInitializer` widget (logic moved to SplashScreen)
- `FutureBuilder` for onboarding check (now in SplashScreen)

## Technical Details

### Dependencies
- No additional packages required
- Uses existing `OnboardingService` for status check
- Uses standard Flutter navigation

### Performance
- Timer starts immediately in `initState`
- Images load while timer runs
- Navigation happens after 3 seconds regardless of image load time

### Error Handling
- If `splash.png` fails to load → white background shown
- If `terminal_logo_black.png` fails to load → empty space shown
- App still functions and navigates correctly

## Customization

### Change Background
Replace `assets/images/splash.png` with your image, keeping the same filename.

### Change Logo
Replace `assets/images/terminal_logo_black.png` with your logo, keeping the same filename.

### Add Animation (Optional)
You can add fade-in animation to the logo:
```dart
AnimatedOpacity(
  opacity: _visible ? 1.0 : 0.0,
  duration: Duration(milliseconds: 500),
  child: Image.asset('assets/images/terminal_logo_black.png'),
)
```

## Platform Support

Works on:
- ✅ iOS
- ✅ Android
- ✅ Web
- ✅ Desktop (macOS, Windows, Linux)

## Notes

- **No back button:** Users cannot navigate back to splash screen
- **One-time display:** Shows on every app launch (not just first launch)
- **3-second guarantee:** Navigation happens exactly 3 seconds after `initState`
- **Memory efficient:** Splash screen is removed from navigation stack after transition

## Troubleshooting

### Splash screen shows white background
- Check if `splash.png` exists in `assets/images/`
- Run `flutter pub get` after adding images
- Hot restart (R) the app, not hot reload (r)

### Logo doesn't appear
- Check if `terminal_logo_black.png` exists in `assets/images/`
- Verify assets are declared in `pubspec.yaml`
- Hot restart the app

### Navigates immediately without delay
- Check if `Future.delayed` duration is correct
- Ensure `await` is present before the delay

### Goes to wrong screen
- Verify `OnboardingService.isOnboardingCompleted()` logic
- Check onboarding completion status in SharedPreferences

## Summary

✅ Splash screen displays for 3 seconds  
✅ Full-screen background with centered logo  
✅ Smooth navigation to onboarding or home  
✅ No back button to splash  
✅ Error handling for missing images  
✅ Clean code structure  
✅ Easy to customize  


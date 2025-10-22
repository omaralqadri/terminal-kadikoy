import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:terminal_kadikoy/core/theme/app_theme.dart';
import 'package:terminal_kadikoy/core/constants/app_constants.dart';
import 'package:terminal_kadikoy/core/localization/app_localizations_delegate.dart';
import 'package:terminal_kadikoy/core/providers/locale_provider.dart';
import 'package:terminal_kadikoy/core/providers/theme_provider.dart';
import 'package:terminal_kadikoy/core/services/onboarding_service.dart';
import 'package:terminal_kadikoy/features/home/screens/home_screen.dart';
import 'package:terminal_kadikoy/features/onboarding/screens/onboarding_screen.dart';

void main() {
  runApp(
    // ProviderScope is required for Riverpod
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch locale and theme changes
    final locale = ref.watch(localeProvider);
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,

      // Theme Configuration
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,

      // Localization Configuration
      locale: locale,
      supportedLocales: const [
        Locale(AppConstants.englishCode),
        Locale(AppConstants.turkishCode),
      ],
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // Initial route handler
      home: const AppInitializer(),
    );
  }
}

/// Widget that determines which screen to show on app launch
class AppInitializer extends StatefulWidget {
  const AppInitializer({super.key});

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: OnboardingService.isOnboardingCompleted(),
      builder: (context, snapshot) {
        // Show loading indicator while checking
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // Show onboarding if not completed, otherwise show home
        final hasCompletedOnboarding = snapshot.data ?? false;
        if (hasCompletedOnboarding) {
          return const HomeScreen();
        } else {
          return const OnboardingScreen();
        }
      },
    );
  }
}

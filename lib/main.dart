import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:terminal_kadikoy/core/theme/app_theme.dart';
import 'package:terminal_kadikoy/core/constants/app_constants.dart';
import 'package:terminal_kadikoy/core/localization/app_localizations_delegate.dart';
import 'package:terminal_kadikoy/core/providers/locale_provider.dart';
import 'package:terminal_kadikoy/core/providers/theme_provider.dart';
import 'package:terminal_kadikoy/features/splash/screens/splash_screen.dart';

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

      // Initial screen - Splash Screen
      home: const SplashScreen(),
    );
  }
}

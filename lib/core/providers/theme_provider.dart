import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// State notifier for managing app theme
class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.light);

  /// Toggle between light and dark theme
  void toggleTheme() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }

  /// Set specific theme mode
  void setTheme(ThemeMode mode) {
    state = mode;
  }

  /// Check if dark mode is enabled
  bool get isDarkMode => state == ThemeMode.dark;
}

/// Provider for app theme mode
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});


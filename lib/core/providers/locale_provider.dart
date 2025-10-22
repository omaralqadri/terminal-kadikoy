import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:terminal_kadikoy/core/constants/app_constants.dart';

/// State notifier for managing app locale
class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(const Locale(AppConstants.defaultLanguage));

  /// Change the app locale
  void changeLocale(String languageCode) {
    state = Locale(languageCode);
  }

  /// Toggle between English and Turkish
  void toggleLocale() {
    if (state.languageCode == AppConstants.englishCode) {
      changeLocale(AppConstants.turkishCode);
    } else {
      changeLocale(AppConstants.englishCode);
    }
  }
}

/// Provider for app locale
final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});


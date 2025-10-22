import 'package:flutter/material.dart';
import 'package:terminal_kadikoy/core/localization/app_localizations.dart';
import 'package:terminal_kadikoy/core/localization/app_localizations_en.dart';
import 'package:terminal_kadikoy/core/localization/app_localizations_tr.dart';
import 'package:terminal_kadikoy/core/constants/app_constants.dart';

/// Delegate for loading localized resources
class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return [AppConstants.englishCode, AppConstants.turkishCode]
        .contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    switch (locale.languageCode) {
      case AppConstants.turkishCode:
        return AppLocalizationsTr();
      case AppConstants.englishCode:
      default:
        return AppLocalizationsEn();
    }
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}


import 'package:flutter/material.dart';

/// Abstract class for app localizations
/// This defines all the strings that need to be translated
abstract class AppLocalizations {
  // Common
  String get appName;
  String get yes;
  String get no;
  String get ok;
  String get cancel;
  String get save;
  String get delete;
  String get edit;
  String get search;
  String get loading;
  String get error;
  String get success;
  
  // Navigation
  String get home;
  String get settings;
  String get profile;
  String get back;
  
  // Messages
  String get welcomeMessage;
  String get noDataAvailable;
  String get somethingWentWrong;
  
  // Example feature strings (Home)
  String get homeTitle;
  String get homeSubtitle;
  String get counterLabel;
  String get incrementButton;
  
  // Onboarding
  String get skip;
  String get next;
  String get getStarted;
  String get onboardingScreen1Title;
  String get onboardingScreen1Description;
  String get onboardingScreen1Button;
  String get onboardingScreen2Title;
  String get onboardingScreen2Description;
  String get onboardingScreen2Button;
  String get onboardingScreen3Title;
  String get onboardingScreen3Description;
  String get onboardingScreen3Button;

  /// Helper method to get localized instance from context
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }
}


/// App-wide constants
class AppConstants {
  AppConstants._(); // Private constructor to prevent instantiation

  // App Information
  static const String appName = 'Terminal Kadıköy';
  static const String appVersion = '1.0.0';

  // API Configuration (example)
  // static const String baseUrl = 'https://api.example.com';
  // static const String apiVersion = 'v1';

  // Supported Languages
  static const String englishCode = 'en';
  static const String turkishCode = 'tr';

  // Default Values
  static const String defaultLanguage = englishCode;

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);

  // Padding & Spacing
  static const double paddingXSmall = 4.0;
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 32.0;

  // Border Radius
  static const double radiusSmall = 4.0;
  static const double radiusMedium = 8.0;
  static const double radiusLarge = 12.0;
  static const double radiusXLarge = 16.0;

  // Icon Sizes
  static const double iconSmall = 16.0;
  static const double iconMedium = 24.0;
  static const double iconLarge = 32.0;
  static const double iconXLarge = 48.0;
}


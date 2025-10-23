import 'package:flutter/material.dart';

/// App-wide color definitions
/// All colors used in the app should be defined here
class AppColors {
  AppColors._(); // Private constructor to prevent instantiation

  // Terminal Kadıköy Brand Colors
  static const Color primary = Color(0xFF0000F4); // Blue
  static const Color primaryDark = Color(0xFF0000D4);
  static const Color primaryLight = Color(0xFF3333F5);

  // Secondary Colors
  static const Color secondary = Color(0xFFEC742E); // Orange
  static const Color secondaryDark = Color(0xFFD4651F);
  static const Color secondaryLight = Color(0xFFF0854A);

  // Terminal Kadıköy Specific Colors
  static const Color terminalGreen = Color(0xFF60D045);
  static const Color terminalOrange = Color(0xFFEC742E);
  static const Color terminalBlue = Color(0xFF0000F4);
  static const Color lightGray = Color(0xFFE5E7EB);

  // Background Colors
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF0F0F0);

  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textDisabled = Color(0xFF9E9E9E);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);

  // Divider & Borders
  static const Color divider = Color(0xFFBDBDBD);
  static const Color border = Color(0xFFE0E0E0);

  // Shadow
  static const Color shadow = Color(0x1A000000);

  // Dark Theme Colors (for future use)
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFB3B3B3);
}


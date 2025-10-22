import 'package:shared_preferences/shared_preferences.dart';

/// Service for managing onboarding state persistence
/// Uses SharedPreferences to track if user has completed onboarding
class OnboardingService {
  static const String _onboardingCompletedKey = 'onboarding_completed';

  /// Check if onboarding has been completed
  static Future<bool> isOnboardingCompleted() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_onboardingCompletedKey) ?? false;
    } catch (e) {
      // If there's an error reading, assume onboarding not completed
      return false;
    }
  }

  /// Mark onboarding as completed
  static Future<bool> setOnboardingCompleted() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.setBool(_onboardingCompletedKey, true);
    } catch (e) {
      return false;
    }
  }

  /// Reset onboarding status (useful for testing)
  static Future<bool> resetOnboarding() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.remove(_onboardingCompletedKey);
    } catch (e) {
      return false;
    }
  }
}


import 'dart:async';
import 'package:flutter/material.dart';
import 'package:terminal_kadikoy/core/services/onboarding_service.dart';
import 'package:terminal_kadikoy/features/onboarding/screens/onboarding_screen.dart';
import 'package:terminal_kadikoy/features/home/screens/home_screen.dart';

/// Splash screen shown on app launch for 3 seconds
/// Displays splash.png background with terminal_logo_black centered
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  /// Wait 3 seconds then navigate to onboarding or home based on status
  Future<void> _navigateAfterDelay() async {
    // Wait for 3 seconds
    await Future.delayed(const Duration(seconds: 3));

    // Check onboarding status
    final hasCompletedOnboarding = await OnboardingService.isOnboardingCompleted();

    // Navigate to appropriate screen
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => hasCompletedOnboarding
              ? const HomeScreen()
              : const OnboardingScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image - full screen
          Image.asset(
            'assets/images/splash.png',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              // Fallback to white background if image not found
              return Container(color: Colors.white);
            },
          ),

          // Centered logo
          Center(
            child: Image.asset(
              'assets/images/terminal_logo_black.png',
              height: 54,
              errorBuilder: (context, error, stackTrace) {
                // Fallback if logo not found
                return const SizedBox(height: 100, width: 200);
              },
            ),
          ),
        ],
      ),
    );
  }
}


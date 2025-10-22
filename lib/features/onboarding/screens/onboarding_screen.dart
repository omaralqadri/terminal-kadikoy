import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:terminal_kadikoy/core/localization/app_localizations.dart';
import 'package:terminal_kadikoy/core/constants/app_constants.dart';
import 'package:terminal_kadikoy/core/services/onboarding_service.dart';
import 'package:terminal_kadikoy/features/onboarding/providers/onboarding_provider.dart';
import 'package:terminal_kadikoy/features/onboarding/widgets/page_indicator.dart';
import 'package:terminal_kadikoy/features/home/screens/home_screen.dart';
import 'package:terminal_kadikoy/shared/widgets/custom_button.dart';

/// Onboarding screen shown on first app launch
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  late PageController _pageController;

  // Theme colors for each page
  final List<Color> _pageColors = [
    const Color(0xFF0000FF), // Blue for page 1
    const Color(0xFF4CAF50), // Green for page 2
    const Color(0xFFFF6F00), // Orange for page 3
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _completeOnboarding() async {
    await OnboardingService.setOnboardingCompleted();
    if (mounted) {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const HomeScreen()));
    }
  }

  void _onPageChanged(int page) {
    ref.read(onboardingProvider.notifier).goToPage(page);
  }

  void _nextPage() {
    final state = ref.read(onboardingProvider);
    if (state.isLastPage) {
      _completeOnboarding();
    } else {
      _pageController.nextPage(
        duration: AppConstants.mediumAnimation,
        curve: Curves.easeInOut,
      );
    }
  }

  void _skipOnboarding() {
    _completeOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    final onboardingState = ref.watch(onboardingProvider);
    final localizations = AppLocalizations.of(context);
    final currentPage = onboardingState.currentPage;
    final isLastPage = onboardingState.isLastPage;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // PageView for swipeable content
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: onboardingState.items.length,
            itemBuilder: (context, index) {
              final item = onboardingState.items[index];
              return _buildOnboardingPage(
                context,
                item.imageUrl,
                _getLocalizedTitle(localizations, index),
                _getLocalizedDescription(localizations, index),
              );
            },
          ),

          // Logo positioned with custom padding (left: 30, top: 120)
          Positioned(
            left: 30,
            top: 150,
            child: Image.asset(
              'assets/images/onboarding/terminal_logo_white.png',
              height: 54,
              errorBuilder: (context, error, stackTrace) {
                // Fallback if logo not found
                return const SizedBox(height: 40, width: 100);
              },
            ),
          ),

          // Skip button overlay (top right) with background image
          if (!isLastPage)
            Positioned(
              top: 0,
              right: 0,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.paddingMedium),
                  child: Container(
                    width: 110,
                    height: 40,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage(
                          'assets/images/onboarding/ic_skip_button_background.png',
                        ),
                        fit: BoxFit.scaleDown,
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: ElevatedButton(
                      onPressed: _skipOnboarding,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        shadowColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        localizations.skip,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

          // Bottom content overlay (indicators and button)
          Positioned(
            left: 0,
            right: 0,
            bottom: 50,
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Page indicator
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppConstants.paddingXSmall,
                    ),
                    child: PageIndicator(
                      currentPage: currentPage,
                      totalPages: onboardingState.totalPages,
                      colors: _pageColors,
                    ),
                  ),

                  // Bottom button
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppConstants.paddingSmall,
                      horizontal: AppConstants.paddingLarge,
                    ),
                    child: CustomButton.rounded(
                      text: _getLocalizedButtonText(localizations, currentPage),
                      onPressed: _nextPage,
                      backgroundColor: _pageColors[currentPage],
                      textColor: Colors.white,
                      width: double.infinity,
                      height: 50,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOnboardingPage(
    BuildContext context,
    String imagePath,
    String title,
    String description,
  ) {
    return Stack(
      children: [
        // White background
        Container(color: Colors.white),

        // Image (positioned a bit above center)
        Positioned.fill(
          child: Align(
            alignment: const Alignment(0, -0.3), // A bit above center
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                // Placeholder when image is not found
                return Container(
                  color: Colors.white,
                  child: Center(
                    child: Icon(
                      Icons.image,
                      size: 80,
                      color: Colors.grey.withValues(alpha: 0.3),
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        // Black gradient overlay (top to bottom: black to transparent)
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 1.0),
                // Top: fully opaque
                Colors.black.withValues(alpha: 0.0),
                // Bottom: fully transparent
              ],
              stops: const [0.0, 1.0],
            ),
          ),
        ),

        // Text content at bottom (above indicators)
        Positioned(
          left: 0,
          right: 0,
          bottom: 200, // Above the button and indicator (moved higher)
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.paddingLarge,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Left alignment
              children: [
                // Title - Size 32, CamptonMedium
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontFamily: 'Campton',
                    fontWeight: FontWeight.w500, // CamptonMedium
                  ),
                  textAlign: TextAlign.left, // Left aligned
                ),

                const SizedBox(height: AppConstants.paddingSmall),

                // Description - Size 22, Normal weight
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.left, // Left aligned
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _getLocalizedTitle(AppLocalizations l10n, int index) {
    switch (index) {
      case 0:
        return l10n.onboardingScreen1Title;
      case 1:
        return l10n.onboardingScreen2Title;
      case 2:
        return l10n.onboardingScreen3Title;
      default:
        return '';
    }
  }

  String _getLocalizedDescription(AppLocalizations l10n, int index) {
    switch (index) {
      case 0:
        return l10n.onboardingScreen1Description;
      case 1:
        return l10n.onboardingScreen2Description;
      case 2:
        return l10n.onboardingScreen3Description;
      default:
        return '';
    }
  }

  String _getLocalizedButtonText(AppLocalizations l10n, int index) {
    switch (index) {
      case 0:
        return l10n.onboardingScreen1Button;
      case 1:
        return l10n.onboardingScreen2Button;
      case 2:
        return l10n.onboardingScreen3Button;
      default:
        return l10n.next;
    }
  }
}

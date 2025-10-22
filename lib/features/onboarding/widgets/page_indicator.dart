import 'package:flutter/material.dart';
import 'package:terminal_kadikoy/core/constants/app_constants.dart';

/// Page indicator widget for onboarding screens
/// Shows colored indicator images representing current page progress
class PageIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final List<Color> colors;

  const PageIndicator({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.colors,
  });

  /// Get the indicator image asset path based on page index and current page
  String _getIndicatorImage(int index) {
    // Progressive filling: blue -> green -> orange
    if (index == 0) {
      // First indicator is always blue when reached
      return currentPage >= 0
          ? 'assets/images/onboarding/blue_indicator.png'
          : 'assets/images/onboarding/gray_indicator.png';
    } else if (index == 1) {
      // Second indicator: green when on page 1 or later, gray before
      return currentPage >= 1
          ? 'assets/images/onboarding/green_indicator.png'
          : 'assets/images/onboarding/gray_indicator.png';
    } else if (index == 2) {
      // Third indicator: orange when on page 2, gray before
      return currentPage >= 2
          ? 'assets/images/onboarding/oreng_indicator.png'
          : 'assets/images/onboarding/gray_indicator.png';
    }
    return 'assets/images/onboarding/gray_indicator.png';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalPages,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingXSmall,
          ),
          child: Image.asset(
            _getIndicatorImage(index),
            width: 32,
            height: 32,
            errorBuilder: (context, error, stackTrace) {
              // Fallback to a simple colored circle if image not found
              return Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: index <= currentPage
                      ? colors[index % colors.length]
                      : Colors.grey.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:terminal_kadikoy/core/theme/app_colors.dart';
import 'package:terminal_kadikoy/core/constants/app_constants.dart';

/// Widget to display the counter value
class CounterDisplay extends StatelessWidget {
  final int count;

  const CounterDisplay({
    super.key,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingLarge),
      decoration: BoxDecoration(
        color: AppColors.primary.withAlpha(25),
        borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
        border: Border.all(
          color: AppColors.primary,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Text(
            'Counter',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: AppConstants.paddingSmall),
          Text(
            '$count',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 72,
                ),
          ),
        ],
      ),
    );
  }
}


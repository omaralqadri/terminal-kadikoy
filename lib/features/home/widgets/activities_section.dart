import 'package:flutter/material.dart';
import 'package:terminal_kadikoy/core/theme/app_colors.dart';
import 'package:terminal_kadikoy/features/home/models/home_models.dart';

/// Activities section with horizontal scrollable square icons
class ActivitiesSection extends StatelessWidget {
  const ActivitiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final activities = HomeMockData.activities;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Aktiviteler',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),

        const SizedBox(height: 16),

        // Horizontal Scrollable Activities
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: activities.length,
            itemBuilder: (context, index) {
              final activity = activities[index];
              return Container(
                width: 80,
                margin: const EdgeInsets.only(right: 16),
                child: Column(
                  children: [
                    // Activity Icon
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppColors.terminalOrange,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.asset(
                        activity.iconPath,
                        width: 30,
                        height: 30,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            _getActivityIcon(activity.name),
                            size: 30,
                            color: Colors.white,
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Activity Name
                    Text(
                      activity.name,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  IconData _getActivityIcon(String activityName) {
    switch (activityName) {
      case 'Bilim':
        return Icons.science;
      case 'Müzik':
        return Icons.music_note;
      case 'Film':
        return Icons.movie;
      case 'Sergi':
        return Icons.museum;
      case 'Diğer':
        return Icons.more_horiz;
      default:
        return Icons.info;
    }
  }
}

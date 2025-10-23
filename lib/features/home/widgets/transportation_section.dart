import 'package:flutter/material.dart';
import 'package:terminal_kadikoy/core/theme/app_colors.dart';
import 'package:terminal_kadikoy/features/home/models/home_models.dart';

/// Transportation section with horizontal scrollable circular icons
class TransportationSection extends StatelessWidget {
  const TransportationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final transportation = HomeMockData.transportation;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Nasıl Gelirim?',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Horizontal Scrollable Transportation
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: transportation.length,
            itemBuilder: (context, index) {
              final transport = transportation[index];
              return Container(
                width: 80,
                margin: const EdgeInsets.only(right: 16),
                child: Column(
                  children: [
                    // Transportation Icon
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppColors.lightGray,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        transport.iconPath,
                        width: 30,
                        height: 30,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            _getTransportIcon(transport.name),
                            size: 30,
                            color: AppColors.textSecondary,
                          );
                        },
                      ),
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Transportation Name
                    Text(
                      transport.name,
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

  IconData _getTransportIcon(String transportName) {
    switch (transportName) {
      case 'Araç':
        return Icons.directions_car;
      case 'Otobüs':
        return Icons.directions_bus;
      case 'Metrobüs':
        return Icons.directions_bus;
      case 'Marmaray':
        return Icons.train;
      case 'Tramvay':
        return Icons.tram;
      default:
        return Icons.directions;
    }
  }
}

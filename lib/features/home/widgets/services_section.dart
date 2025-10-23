import 'package:flutter/material.dart';
import 'package:terminal_kadikoy/core/theme/app_colors.dart';
import 'package:terminal_kadikoy/features/home/models/home_models.dart';

/// Services section with horizontal scrollable circular icons
class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final services = HomeMockData.services;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Hizmetlerimiz',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Horizontal Scrollable Services
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: services.length,
            itemBuilder: (context, index) {
              final service = services[index];
              return Container(
                width: 80,
                margin: const EdgeInsets.only(right: 16),
                child: Column(
                  children: [
                    // Service Icon
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppColors.lightGray,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        service.iconPath,
                        width: 30,
                        height: 30,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            _getServiceIcon(service.name),
                            size: 30,
                            color: AppColors.textSecondary,
                          );
                        },
                      ),
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Service Name
                    Text(
                      service.name,
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

  IconData _getServiceIcon(String serviceName) {
    switch (serviceName) {
      case 'Wifi':
        return Icons.wifi;
      case 'ATM':
        return Icons.atm;
      case 'Hayvan Dostu':
        return Icons.pets;
      case 'Eczane':
        return Icons.local_pharmacy;
      case 'Otopark':
        return Icons.local_parking;
      case 'Güvenlik':
        return Icons.security;
      default:
        return Icons.info;
    }
  }
}

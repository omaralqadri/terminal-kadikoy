import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:terminal_kadikoy/core/theme/app_colors.dart';
import 'package:terminal_kadikoy/features/home/widgets/home_app_bar.dart';
import 'package:terminal_kadikoy/features/home/widgets/hero_banner_section.dart';
import 'package:terminal_kadikoy/features/home/widgets/brands_section.dart';
import 'package:terminal_kadikoy/features/home/widgets/events_section.dart';
import 'package:terminal_kadikoy/features/home/widgets/services_section.dart';
import 'package:terminal_kadikoy/features/home/widgets/floor_plans_section.dart';
import 'package:terminal_kadikoy/features/home/widgets/activities_section.dart';
import 'package:terminal_kadikoy/features/home/widgets/transportation_section.dart';
import 'package:terminal_kadikoy/shared/widgets/bottom_nav_bar.dart';
import 'package:terminal_kadikoy/features/home/screens/notification_screen.dart';
import 'package:terminal_kadikoy/features/home/screens/brands_list_screen.dart';
import 'package:terminal_kadikoy/features/home/screens/events_list_screen.dart';
import 'package:terminal_kadikoy/features/home/screens/floor_plans_screen.dart';
import 'package:terminal_kadikoy/features/home/screens/brands_screen.dart';
import 'package:terminal_kadikoy/features/home/screens/events_screen.dart';
import 'package:terminal_kadikoy/features/home/screens/map_screen.dart';

/// Home screen of the application with bottom navigation
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentBottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _currentBottomNavIndex == 0 ? HomeAppBar(
        onNotificationTap: _navigateToNotifications,
      ) : null,
      body: _getCurrentScreen(),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentBottomNavIndex,
        onTap: _onBottomNavTap,
      ),
    );
  }

  Widget _getCurrentScreen() {
    switch (_currentBottomNavIndex) {
      case 0:
        return _buildHomeContent();
      case 1:
        return const BrandsScreen();
      case 2:
        return const EventsScreen();
      case 3:
        return const MapScreen();
      default:
        return _buildHomeContent();
    }
  }

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 16),
          
          // Hero Banner Section
          HeroBannerSection(
            onSeeAllTap: _navigateToBanners,
          ),
          
          const SizedBox(height: 32),
          
          // Brands Section
          BrandsSection(
            onSeeAllTap: _navigateToBrandsList,
          ),
          
          const SizedBox(height: 32),
          
          // Events Section
          EventsSection(
            onSeeAllTap: _navigateToEventsList,
          ),
          
          const SizedBox(height: 32),
          
          // Services Section
          ServicesSection(),
          
          const SizedBox(height: 32),
          
          // Floor Plans Section
          FloorPlansSection(
            onReviewTap: _navigateToFloorPlans,
          ),
          
          const SizedBox(height: 32),
          
          // Activities Section
          ActivitiesSection(),
          
          const SizedBox(height: 32),
          
          // Transportation Section
          TransportationSection(),
          
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _currentBottomNavIndex = index;
    });
  }

  void _navigateToNotifications() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const NotificationScreen(),
      ),
    );
  }

  void _navigateToBanners() {
    // TODO: Navigate to banners list screen when created
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Banner listesi yakında gelecek'),
      ),
    );
  }

  void _navigateToBrandsList() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const BrandsListScreen(),
      ),
    );
  }

  void _navigateToEventsList() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const EventsListScreen(),
      ),
    );
  }

  void _navigateToFloorPlans() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const FloorPlansScreen(),
      ),
    );
  }
}


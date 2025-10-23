import 'package:flutter/material.dart';
import 'package:terminal_kadikoy/core/theme/app_colors.dart';

/// Placeholder brands list screen
class BrandsListScreen extends StatelessWidget {
  const BrandsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Markalar'),
        backgroundColor: AppColors.terminalBlue,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.store,
              size: 80,
              color: AppColors.textSecondary,
            ),
            SizedBox(height: 16),
            Text(
              'Markalar listesi yakında gelecek',
              style: TextStyle(
                fontSize: 18,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

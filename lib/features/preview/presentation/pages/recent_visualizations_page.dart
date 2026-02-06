import 'package:flutter/material.dart';
import 'package:showroom/core/constants/app_colors.dart';
import 'package:showroom/core/constants/app_strings.dart';

class RecentVisualizationsPage extends StatelessWidget {
  const RecentVisualizationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recent Visualizations'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Luxury icon
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFD4AF37),
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.history,
                size: 64,
                color: const Color(0xFFD4AF37),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Coming Soon',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: Text(
                'Your recent fabric visualizations will appear here.\nStay tuned for this premium feature!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

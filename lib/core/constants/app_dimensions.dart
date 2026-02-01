import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Tablet-optimized dimensions and spacing constants
class AppDimensions {
  AppDimensions._();

  // Spacing
  static double spacing4 = 4.w;
  static double spacing8 = 8.w;
  static double spacing12 = 12.w;
  static double spacing16 = 16.w;
  static double spacing20 = 20.w;
  static double spacing24 = 24.w;
  static double spacing32 = 32.w;
  static double spacing40 = 40.w;
  static double spacing48 = 48.w;

  // Touch targets (minimum 56dp for tablet)
  static double minTouchTarget = 56.h;

  // Card dimensions
  static double cardElevation = 2.0;
  static double cardRadius = 16.r;
  static double fabricCardHeight = 220.h;
  static double fabricCardWidth = 180.w;

  // Object selector card
  static double objectCardHeight = 180.h;

  // Button dimensions
  static double buttonHeight = 56.h;
  static double buttonRadius = 12.r;

  // Bottom navigation
  static double bottomNavHeight = 70.h;
  static double bottomNavIconSize = 28.sp;

  // Preview carousel
  static double previewImageHeight = 400.h;
  static double pageIndicatorSize = 8.r;

  // Grid spacing
  static double gridSpacing = 16.w;
  static int catalogGridCrossAxisCount = 4;
}

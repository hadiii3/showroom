import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:showroom/core/constants/app_colors.dart';

enum SnackBarType { success, error, info, warning }

class LuxurySnackBar {
  static void show(
    BuildContext context, {
    required String message,
    required SnackBarType type,
    Duration duration = const Duration(seconds: 3),
  }) {
    final colors = _getColors(type);
    final icon = _getIcon(type);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: colors.accentColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                icon,
                color: colors.accentColor,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF2D2D2D),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: BorderSide(
            color: colors.accentColor.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        margin: EdgeInsets.all(16.w),
        elevation: 8,
        duration: duration,
      ),
    );
  }

  static _SnackBarColors _getColors(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return _SnackBarColors(
          accentColor: const Color(0xFFD4AF37), // Gold
          backgroundColor: const Color(0xFF2D2D2D),
        );
      case SnackBarType.error:
        return _SnackBarColors(
          accentColor: const Color(0xFFE74C3C), // Luxury red
          backgroundColor: const Color(0xFF2D2D2D),
        );
      case SnackBarType.info:
        return _SnackBarColors(
          accentColor: const Color(0xFF3498DB), // Blue
          backgroundColor: const Color(0xFF2D2D2D),
        );
      case SnackBarType.warning:
        return _SnackBarColors(
          accentColor: const Color(0xFFF39C12), // Amber
          backgroundColor: const Color(0xFF2D2D2D),
        );
    }
  }

  static IconData _getIcon(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return Icons.check_circle_outline;
      case SnackBarType.error:
        return Icons.error_outline;
      case SnackBarType.info:
        return Icons.info_outline;
      case SnackBarType.warning:
        return Icons.warning_amber_outlined;
    }
  }
}

class _SnackBarColors {
  final Color accentColor;
  final Color backgroundColor;

  _SnackBarColors({
    required this.accentColor,
    required this.backgroundColor,
  });
}

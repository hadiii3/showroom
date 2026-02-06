import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:showroom/core/constants/app_colors.dart';
import 'package:showroom/core/constants/app_dimensions.dart';
import 'package:showroom/features/catalog/presentation/pages/catalog_selection_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              AppColors.beige.withOpacity(0.2),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.spacing48,
                  vertical: AppDimensions.spacing32,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 40.h),

                    // Brand Icon/Logo Area
                    Container(
                      padding: EdgeInsets.all(24.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFD4AF37),
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        Icons.auto_awesome,
                        size: 64.sp,
                        color: const Color(0xFFD4AF37),
                      ),
                    ),

                    SizedBox(height: 40.h),

                    // Brand Name
                    Text(
                      'Premium Fabric',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 56.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                        letterSpacing: -1,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    Text(
                      'Showroom',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 56.sp,
                        fontWeight: FontWeight.w300,
                        color: AppColors.textPrimary,
                        letterSpacing: 2,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 24.h),

                    // Tagline
                    Text(
                      'Experience Luxury Fabrics in Your Space',
                      style: GoogleFonts.inter(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textSecondary,
                        letterSpacing: 0.5,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 16.h),

                    // Description
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 80.w),
                      child: Text(
                        'Visualize premium fabrics on curtains and couches.\nTransform your interior with our curated collection.',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          color: AppColors.textTertiary,
                          height: 1.6,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    SizedBox(height: 60.h),

                    // CTA Button
                    SizedBox(
                      width: 400.w,
                      height: 64.h,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const CatalogSelectionPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD4AF37),
                          foregroundColor: Colors.white,
                          elevation: 8,
                          shadowColor: const Color(0xFFD4AF37).withOpacity(0.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.r),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Start Visualizing',
                              style: GoogleFonts.inter(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Icon(Icons.arrow_forward, size: 24.sp),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:showroom/core/constants/app_colors.dart';
import 'package:showroom/core/constants/app_dimensions.dart';
import 'package:showroom/features/catalog/presentation/pages/catalog_page.dart';

class CatalogSelectionPage extends StatelessWidget {
  const CatalogSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Your Project'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(AppDimensions.spacing32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title
            Text(
              'What would you like to visualize?',
              style: GoogleFonts.playfairDisplay(
                fontSize: 32.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 16.h),

            Text(
              'Select your furniture type to begin',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: AppDimensions.spacing48),

            // Selection cards
            Expanded(
              child: Row(
                children: [
                  // Curtains
                  Expanded(
                    child: _SelectionCard(
                      title: 'Curtains',
                      subtitle: 'Window treatments',
                      icon: Icons.window_outlined,
                      imageUrl:
                          'https://images.unsplash.com/photo-1609779562540-6f2ff4a60cd9?w=600',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const CatalogPage(furnitureType: 'curtain'),
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(width: AppDimensions.spacing24),

                  // Couches
                  Expanded(
                    child: _SelectionCard(
                      title: 'Couches',
                      subtitle: 'Upholstery',
                      icon: Icons.weekend_outlined,
                      imageUrl:
                          'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=600',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const CatalogPage(furnitureType: 'couch'),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectionCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String imageUrl;
  final VoidCallback onTap;

  const _SelectionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  State<_SelectionCard> createState() => _SelectionCardState();
}

class _SelectionCardState extends State<_SelectionCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: Matrix4.identity()..scale(_isHovered ? 1.02 : 1.0),
        child: Card(
          elevation: _isHovered ? 12 : 4,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
            side: BorderSide(
              color: _isHovered ? const Color(0xFFD4AF37) : Colors.transparent,
              width: 2,
            ),
          ),
          child: InkWell(
            onTap: widget.onTap,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Background image
                Image.network(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppColors.beige,
                      child: Icon(widget.icon, size: 100.sp),
                    );
                  },
                ),

                // Gradient
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.2),
                        Colors.black.withOpacity(0.6),
                      ],
                    ),
                  ),
                ),

                // Content
                Positioned(
                  left: 24.w,
                  right: 24.w,
                  bottom: 32.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        widget.icon,
                        color: const Color(0xFFD4AF37),
                        size: 56.sp,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        widget.title,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        widget.subtitle,
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

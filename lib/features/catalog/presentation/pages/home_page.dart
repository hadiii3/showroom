import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:showroom/core/constants/app_colors.dart';
import 'package:showroom/core/constants/app_dimensions.dart';
import 'package:showroom/features/catalog/presentation/pages/catalog_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Elegant background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.white,
                  AppColors.beige.withOpacity(0.3),
                ],
              ),
            ),
          ),

          // Content
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.spacing48,
                vertical: AppDimensions.spacing32,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Premium header
                  Text(
                    'Premium Fabrics',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 48.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                      letterSpacing: -0.5,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Elevate Your Space',
                    style: GoogleFonts.inter(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
                      letterSpacing: 0.5,
                    ),
                  ),

                  SizedBox(height: AppDimensions.spacing48),

                  // Selection cards
                  Expanded(
                    child: Row(
                      children: [
                        // Curtains Card
                        Expanded(
                          child: _LuxurySelectionCard(
                            title: 'Curtains',
                            subtitle: 'Elegant window treatments',
                            imageUrl:
                                'https://images.unsplash.com/photo-1609779562540-6f2ff4a60cd9?w=800',
                            icon: Icons.window_outlined,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CatalogPage(
                                      furnitureType: 'curtain'),
                                ),
                              );
                            },
                          ),
                        ),

                        SizedBox(width: AppDimensions.spacing24),

                        // Couch Card
                        Expanded(
                          child: _LuxurySelectionCard(
                            title: 'Couches',
                            subtitle: 'Luxurious upholstery',
                            imageUrl:
                                'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=800',
                            icon: Icons.weekend_outlined,
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
          ),
        ],
      ),
    );
  }
}

class _LuxurySelectionCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final IconData icon;
  final VoidCallback onTap;

  const _LuxurySelectionCard({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.icon,
    required this.onTap,
  });

  @override
  State<_LuxurySelectionCard> createState() => _LuxurySelectionCardState();
}

class _LuxurySelectionCardState extends State<_LuxurySelectionCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        transform: Matrix4.identity()..scale(_isHovered ? 1.02 : 1.0),
        child: Card(
          elevation: _isHovered ? 16 : 8,
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
                      child: Icon(widget.icon, size: 120.sp),
                    );
                  },
                ),

                // Gradient overlay
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.3),
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),

                // Content
                Positioned(
                  left: AppDimensions.spacing24,
                  right: AppDimensions.spacing24,
                  bottom: AppDimensions.spacing32,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        widget.icon,
                        color: const Color(0xFFD4AF37),
                        size: 48.sp,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        widget.title,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 36.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        widget.subtitle,
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
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

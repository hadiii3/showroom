import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:showroom/core/constants/app_colors.dart';
import 'package:showroom/core/constants/app_strings.dart';
import 'package:showroom/core/constants/app_dimensions.dart';
import 'package:showroom/features/catalog/data/models/fabric_model.dart';
import 'package:showroom/features/selection/data/models/furniture_model.dart';

class VisualizationPreviewPage extends StatefulWidget {
  final FabricModel fabric;
  final FurnitureModel furniture;

  const VisualizationPreviewPage({
    super.key,
    required this.fabric,
    required this.furniture,
  });

  @override
  State<VisualizationPreviewPage> createState() =>
      _VisualizationPreviewPageState();
}

class _VisualizationPreviewPageState extends State<VisualizationPreviewPage> {
  int _currentAngleIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.visualizationPreview),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Saved to recent')));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Carousel
          Expanded(
            flex: 2,
            child: Container(
              color: AppColors.backgroundSecondary,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Angle PageView
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: widget.furniture.angleImageUrls.length,
                      onPageChanged: (index) {
                        setState(() => _currentAngleIndex = index);
                      },
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              // Furniture visualization (simulated)
                              Image.network(
                                widget.furniture.angleImageUrls[index],
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: AppColors.beige,
                                    child: const Icon(Icons.image, size: 64),
                                  );
                                },
                              ),

                              // Overlay indicator
                              Positioned(
                                bottom: 16,
                                left: 16,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 8.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    'Angle ${index + 1}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: AppDimensions.spacing16),

                  // Page Indicator
                  Padding(
                    padding: EdgeInsets.only(bottom: AppDimensions.spacing16),
                    child: AnimatedSmoothIndicator(
                      activeIndex: _currentAngleIndex,
                      count: widget.furniture.angleImageUrls.length,
                      effect: WormEffect(
                        dotWidth: AppDimensions.pageIndicatorSize.toDouble(),
                        dotHeight: AppDimensions.pageIndicatorSize.toDouble(),
                        activeDotColor: AppColors.accent,
                        dotColor: AppColors.divider,
                      ),
                    ),
                  ),

                  SizedBox(height: AppDimensions.spacing8),

                  Text(
                    AppStrings.swipeForAngles,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),

          // Info Panel
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(AppDimensions.spacing24),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      AppStrings.currentSelection,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),

                    SizedBox(height: AppDimensions.spacing16),

                    // Selection Info Cards
                    Row(
                      children: [
                        Expanded(
                          child: _InfoCard(
                            title: AppStrings.fabric,
                            subtitle: widget.fabric.name,
                            imageUrl: widget.fabric.imageUrl,
                          ),
                        ),
                        SizedBox(width: AppDimensions.spacing16),
                        Expanded(
                          child: _InfoCard(
                            title: AppStrings.object,
                            subtitle: widget.furniture.name,
                            imageUrl: widget.furniture.angleImageUrls.first,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: AppDimensions.spacing24),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.texture),
                            label: const Text(AppStrings.changeFabric),
                          ),
                        ),
                        SizedBox(width: AppDimensions.spacing12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Saved to recent visualizations!',
                                  ),
                                ),
                              );
                              Navigator.popUntil(
                                context,
                                (route) => route.isFirst,
                              );
                            },
                            icon: const Icon(Icons.save),
                            label: const Text(AppStrings.saveToRecent),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;

  const _InfoCard({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.spacing8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.network(
                imageUrl,
                width: 50.w,
                height: 50.h,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 50.w,
                    height: 50.h,
                    color: AppColors.beige,
                  );
                },
              ),
            ),
            SizedBox(width: AppDimensions.spacing8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.labelSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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

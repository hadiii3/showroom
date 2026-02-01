import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:showroom/core/constants/app_colors.dart';
import 'package:showroom/core/constants/app_strings.dart';
import 'package:showroom/core/constants/app_dimensions.dart';
import 'package:showroom/features/catalog/data/models/fabric_model.dart';
import 'package:showroom/features/selection/presentation/pages/furniture_selection_page.dart';

class FabricDetailsPage extends StatelessWidget {
  final FabricModel fabric;
  final String furnitureType;

  const FabricDetailsPage({
    super.key,
    required this.fabric,
    required this.furnitureType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Hero Image
          SliverAppBar(
            expandedHeight: 400.h,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                fabric.closeUpImageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(color: AppColors.beige);
                },
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Container(
              color: AppColors.backgroundPrimary,
              padding: EdgeInsets.all(AppDimensions.spacing24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name & Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          fabric.name,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                      Text(
                        '\$${fabric.pricePerYard.toStringAsFixed(0)}',
                        style: Theme.of(context).textTheme.headlineLarge
                            ?.copyWith(color: AppColors.accent),
                      ),
                    ],
                  ),

                  SizedBox(height: AppDimensions.spacing8),

                  Text(
                    fabric.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),

                  SizedBox(height: AppDimensions.spacing32),

                  // Specifications Grid
                  _SpecsGrid(fabric: fabric),

                  SizedBox(height: AppDimensions.spacing32),

                  // Care Instructions
                  Text(
                    AppStrings.care,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(height: AppDimensions.spacing12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: fabric.careInstructions
                        .map(
                          (care) => Chip(
                            label: Text(care.replaceAll('-', ' ')),
                            backgroundColor: AppColors.beige,
                          ),
                        )
                        .toList(),
                  ),

                  SizedBox(height: AppDimensions.spacing48),

                  // Visualize Button
                  SizedBox(
                    width: double.infinity,
                    height: AppDimensions.buttonHeight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FurnitureSelectionPage(
                              fabric: fabric,
                              furnitureType: furnitureType,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        furnitureType == 'curtain'
                            ? '${AppStrings.visualizeThisFabric} ${AppStrings.onCurtains}'
                            : '${AppStrings.visualizeThisFabric} ${AppStrings.onCouch}',
                      ),
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

class _SpecsGrid extends StatelessWidget {
  final FabricModel fabric;

  const _SpecsGrid({required this.fabric});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppDimensions.spacing16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: [
          _SpecRow(label: AppStrings.composition, value: fabric.composition),
          Divider(height: AppDimensions.spacing24),
          _SpecRow(
            label: AppStrings.durability,
            value: '${fabric.durability.toString()} rubs',
          ),
          Divider(height: AppDimensions.spacing24),
          _SpecRow(label: AppStrings.origin, value: fabric.origin),
        ],
      ),
    );
  }
}

class _SpecRow extends StatelessWidget {
  final String label;
  final String value;

  const _SpecRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.labelLarge?.copyWith(color: AppColors.textSecondary),
        ),
        Text(value, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:showroom/core/constants/app_colors.dart';
import 'package:showroom/core/constants/app_strings.dart';
import 'package:showroom/core/constants/app_dimensions.dart';
import 'package:showroom/core/widgets/shimmer_loading.dart';
import 'package:showroom/features/catalog/domain/entities/fabric.dart';
import 'package:showroom/features/selection/presentation/bloc/furniture_bloc.dart';
import 'package:showroom/features/selection/presentation/bloc/furniture_event.dart';
import 'package:showroom/features/selection/presentation/bloc/furniture_state.dart';
import 'package:showroom/features/selection/domain/entities/furniture.dart';
import 'package:showroom/features/preview/presentation/pages/visualization_preview_page.dart';

class FurnitureSelectionPage extends StatelessWidget {
  final Fabric fabric;
  final String furnitureType;

  const FurnitureSelectionPage({
    super.key,
    required this.fabric,
    required this.furnitureType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          furnitureType == 'curtain'
              ? AppStrings.selectCurtain
              : AppStrings.selectCouch,
        ),
      ),
      body: BlocBuilder<FurnitureBloc, FurnitureState>(
        builder: (context, state) {
          if (state is FurnitureLoading) {
            return const Center(child: ShimmerGrid());
          }

          if (state is FurnitureError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64.sp,
                    color: AppColors.error,
                  ),
                  SizedBox(height: AppDimensions.spacing16),
                  Text(
                    state.message,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: AppDimensions.spacing24),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<FurnitureBloc>()
                          .add(LoadFurnitureEvent(furnitureType));
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is FurnitureLoaded) {
            return GridView.builder(
              padding: EdgeInsets.all(AppDimensions.spacing24),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.75,
                crossAxisSpacing: AppDimensions.spacing24,
                mainAxisSpacing: AppDimensions.spacing24,
              ),
              itemCount: state.furniture.length,
              itemBuilder: (context, index) {
                final item = state.furniture[index];
                return _FurnitureCard(
                  furniture: item,
                  fabric: fabric,
                  furnitureType: furnitureType,
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _FurnitureCard extends StatelessWidget {
  final Furniture furniture;
  final Fabric fabric;
  final String furnitureType;

  const _FurnitureCard({
    required this.furniture,
    required this.fabric,
    required this.furnitureType,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VisualizationPreviewPage(
                fabric: fabric,
                furniture: furniture,
                furnitureType: furnitureType,
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(furniture.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.3),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(AppDimensions.spacing12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    furniture.name,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    furniture.style,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
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

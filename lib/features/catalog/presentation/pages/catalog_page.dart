import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:showroom/core/constants/app_colors.dart';
import 'package:showroom/core/constants/app_strings.dart';
import 'package:showroom/core/constants/app_dimensions.dart';
import 'package:showroom/core/widgets/shimmer_loading.dart';
import 'package:showroom/features/catalog/presentation/bloc/catalog_bloc.dart';
import 'package:showroom/features/catalog/presentation/bloc/catalog_event.dart';
import 'package:showroom/features/catalog/presentation/bloc/catalog_state.dart';
import 'package:showroom/features/catalog/presentation/pages/fabric_details_page.dart';
import 'package:showroom/features/catalog/domain/entities/fabric.dart';

class CatalogPage extends StatelessWidget {
  final String furnitureType;

  const CatalogPage({super.key, required this.furnitureType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          furnitureType == 'curtain'
              ? AppStrings.curtainCatalog
              : AppStrings.couchCatalog,
        ),
        actions: [
          BlocBuilder<CatalogBloc, CatalogState>(
            builder: (context, state) {
              if (state is CatalogLoaded &&
                  (state.selectedColor != null ||
                      state.selectedMaterial != null)) {
                return TextButton.icon(
                  onPressed: () {
                    context.read<CatalogBloc>().add(const ClearFiltersEvent());
                  },
                  icon: const Icon(Icons.clear),
                  label: const Text(AppStrings.clearFilters),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: BlocBuilder<CatalogBloc, CatalogState>(
        builder: (context, state) {
          if (state is CatalogLoading) {
            return Row(
              children: [
                Container(
                  width: 250.w,
                  color: AppColors.backgroundSecondary,
                ),
                const Expanded(child: ShimmerGrid()),
              ],
            );
          }

          if (state is CatalogError) {
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
                      context.read<CatalogBloc>().add(const LoadFabricsEvent());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is CatalogLoaded) {
            return Row(
              children: [
                // Filter Sidebar
                _FilterSidebar(
                  fabrics: state.fabrics,
                  selectedColor: state.selectedColor,
                  selectedMaterial: state.selectedMaterial,
                ),
                // Fabric Grid
                Expanded(
                  child: state.filteredFabrics.isEmpty
                      ? _EmptyState()
                      : _FabricGrid(fabrics: state.filteredFabrics),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _FilterSidebar extends StatelessWidget {
  final List<Fabric> fabrics;
  final String? selectedColor;
  final String? selectedMaterial;

  const _FilterSidebar({
    required this.fabrics,
    this.selectedColor,
    this.selectedMaterial,
  });

  @override
  Widget build(BuildContext context) {
    final colors = fabrics.map((f) => f.color).toSet().toList()..sort();
    final materials = fabrics.map((f) => f.material).toSet().toList()..sort();

    return Container(
      width: 250.w,
      color: AppColors.backgroundSecondary,
      padding: EdgeInsets.all(AppDimensions.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.filters,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: AppDimensions.spacing24),

          // Color Filter
          Text(
            AppStrings.color,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: AppDimensions.spacing8),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: colors.map((color) {
              final isSelected = selectedColor == color;
              return FilterChip(
                label: Text(color),
                selected: isSelected,
                onSelected: (selected) {
                  context.read<CatalogBloc>().add(
                        FilterFabricsEvent(
                          color: selected ? color : null,
                          material: selectedMaterial,
                        ),
                      );
                },
              );
            }).toList(),
          ),

          SizedBox(height: AppDimensions.spacing24),

          // Material Filter
          Text(
            AppStrings.material,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: AppDimensions.spacing8),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: materials.map((material) {
              final isSelected = selectedMaterial == material;
              return FilterChip(
                label: Text(material),
                selected: isSelected,
                onSelected: (selected) {
                  context.read<CatalogBloc>().add(
                        FilterFabricsEvent(
                          color: selectedColor,
                          material: selected ? material : null,
                        ),
                      );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _FabricGrid extends StatelessWidget {
  final List<Fabric> fabrics;

  const _FabricGrid({required this.fabrics});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(AppDimensions.spacing16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.75,
        crossAxisSpacing: AppDimensions.spacing16,
        mainAxisSpacing: AppDimensions.spacing16,
      ),
      itemCount: fabrics.length,
      itemBuilder: (context, index) {
        final fabric = fabrics[index];
        return _FabricCard(fabric: fabric);
      },
    );
  }
}

class _FabricCard extends StatelessWidget {
  final Fabric fabric;

  const _FabricCard({required this.fabric});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FabricDetailsPage(fabric: fabric),
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
                    image: NetworkImage(fabric.imageUrl),
                    fit: BoxFit.cover,
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
                    fabric.name,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${fabric.color} • ${fabric.material}',
                    style: Theme.of(context).textTheme.bodySmall,
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

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64.sp,
            color: AppColors.textTertiary,
          ),
          SizedBox(height: AppDimensions.spacing16),
          Text(
            'No fabrics found',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: AppDimensions.spacing8),
          Text(
            'Try adjusting your filters',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textTtertiary,
                ),
          ),
        ],
      ),
    );
  }
}

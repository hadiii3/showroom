import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:showroom/core/constants/app_colors.dart';
import 'package:showroom/core/constants/app_strings.dart';
import 'package:showroom/core/constants/app_dimensions.dart';
import 'package:showroom/features/catalog/data/datasources/fabric_remote_datasource.dart';
import 'package:showroom/features/catalog/data/models/fabric_model.dart';
import 'package:showroom/features/catalog/presentation/pages/fabric_details_page.dart';
import 'package:showroom/core/widgets/shimmer_loading.dart';

class CatalogPage extends StatefulWidget {
  final String furnitureType;

  const CatalogPage({super.key, required this.furnitureType});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  final _dataSource = FabricRemoteDataSourceImpl();
  List<FabricModel> _fabrics = [];
  List<FabricModel> _filteredFabrics = [];
  bool _isLoading = true;
  String? _selectedColor;
  String? _selectedMaterial;

  @override
  void initState() {
    super.initState();
    _loadFabrics();
  }

  Future<void> _loadFabrics() async {
    setState(() => _isLoading = true);

    try {
      final fabrics = await _dataSource.getAllFabrics();
      setState(() {
        _fabrics = fabrics;
        _filteredFabrics = fabrics;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  void _applyFilters() {
    setState(() {
      _filteredFabrics = _fabrics.where((fabric) {
        bool matchesColor =
            _selectedColor == null || fabric.color == _selectedColor;
        bool matchesMaterial =
            _selectedMaterial == null || fabric.material == _selectedMaterial;
        return matchesColor && matchesMaterial;
      }).toList();
    });
  }

  void _clearFilters() {
    setState(() {
      _selectedColor = null;
      _selectedMaterial = null;
      _filteredFabrics = _fabrics;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.fabricCatalog),
        actions: [
          if (_selectedColor != null || _selectedMaterial != null)
            TextButton.icon(
              onPressed: _clearFilters,
              icon: const Icon(Icons.clear),
              label: const Text(AppStrings.clearFilters),
            ),
        ],
      ),
      body: _isLoading
          ? Row(
              children: [
                Container(
                  width: 250.w,
                  color: AppColors.backgroundSecondary,
                ),
                const Expanded(child: ShimmerGrid()),
              ],
            )
          : Row(
              children: [
                // Filter Sidebar
                Container(
                  width: 250.w,
                  color: AppColors.backgroundSecondary,
                  padding: EdgeInsets.all(AppDimensions.spacing16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.filters,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      SizedBox(height: AppDimensions.spacing24),

                      // Color Filter
                      Text(
                        'Color',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      SizedBox(height: AppDimensions.spacing8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          'neutral',
                          'blue',
                          'beige',
                          'green',
                          'white',
                          'gray',
                        ]
                            .map(
                              (color) => FilterChip(
                                label: Text(color),
                                selected: _selectedColor == color,
                                onSelected: (selected) {
                                  setState(() {
                                    _selectedColor = selected ? color : null;
                                    _applyFilters();
                                  });
                                },
                              ),
                            )
                            .toList(),
                      ),

                      SizedBox(height: AppDimensions.spacing24),

                      // Material Filter
                      Text(
                        'Material',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      SizedBox(height: AppDimensions.spacing8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          'linen',
                          'velvet',
                          'chenille',
                          'silk',
                          'wool',
                          'cotton',
                        ]
                            .map(
                              (material) => FilterChip(
                                label: Text(material),
                                selected: _selectedMaterial == material,
                                onSelected: (selected) {
                                  setState(() {
                                    _selectedMaterial =
                                        selected ? material : null;
                                    _applyFilters();
                                  });
                                },
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),

                // Fabric Grid
                Expanded(
                  child: _filteredFabrics.isEmpty
                      ? const Center(
                          child: Text('No fabrics match your filters'),
                        )
                      : GridView.builder(
                          padding: EdgeInsets.all(AppDimensions.spacing16),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: AppDimensions.gridSpacing,
                            mainAxisSpacing: AppDimensions.gridSpacing,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: _filteredFabrics.length,
                          itemBuilder: (context, index) {
                            final fabric = _filteredFabrics[index];
                            return _FabricCard(
                              fabric: fabric,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FabricDetailsPage(
                                      fabric: fabric,
                                      furnitureType: widget.furnitureType,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}

class _FabricCard extends StatelessWidget {
  final FabricModel fabric;
  final VoidCallback onTap;

  const _FabricCard({required this.fabric, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.network(
                fabric.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.beige,
                    child: const Icon(Icons.texture, size: 48),
                  );
                },
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
                    fabric.material.toUpperCase(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '\$${fabric.pricePerYard.toStringAsFixed(0)} ${AppStrings.pricePerYard}',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: AppColors.accent,
                          fontWeight: FontWeight.w600,
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

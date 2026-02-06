import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:showroom/core/constants/app_colors.dart';
import 'package:showroom/core/constants/app_strings.dart';
import 'package:showroom/core/constants/app_dimensions.dart';
import 'package:showroom/features/catalog/data/models/fabric_model.dart';
import 'package:showroom/features/selection/data/datasources/furniture_remote_datasource.dart';
import 'package:showroom/features/selection/data/models/furniture_model.dart';
import 'package:showroom/features/preview/presentation/pages/visualization_preview_page.dart';

class FurnitureSelectionPage extends StatefulWidget {
  final FabricModel fabric;
  final String furnitureType;

  const FurnitureSelectionPage({
    super.key,
    required this.fabric,
    required this.furnitureType,
  });

  @override
  State<FurnitureSelectionPage> createState() => _FurnitureSelectionPageState();
}

class _FurnitureSelectionPageState extends State<FurnitureSelectionPage> {
  final _dataSource = FurnitureRemoteDataSourceImpl();
  List<FurnitureModel> _furniture = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFurniture();
  }

  Future<void> _loadFurniture() async {
    setState(() => _isLoading = true);

    try {
      final furniture = await _dataSource.getFurnitureByType(
        widget.furnitureType,
      );
      setState(() {
        _furniture = furniture;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.furnitureType == 'curtain'
        ? AppStrings.curtainStyles
        : AppStrings.couchSelection;

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Header
                Container(
                  padding: EdgeInsets.all(AppDimensions.spacing24),
                  color: AppColors.backgroundSecondary,
                  child: Column(
                    children: [
                      Text(
                        widget.furnitureType == 'curtain'
                            ? AppStrings.selectCurtainType
                            : AppStrings.selectYourCouch,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      SizedBox(height: AppDimensions.spacing8),
                      Text(
                        widget.furnitureType == 'curtain'
                            ? AppStrings.chooseStyle
                            : AppStrings.chooseBestModel,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                // Furniture Grid
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.all(AppDimensions.spacing24),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: widget.furnitureType == 'curtain' ? 3 : 2,
                      crossAxisSpacing: AppDimensions.gridSpacing * 2,
                      mainAxisSpacing: AppDimensions.gridSpacing * 2,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: _furniture.length,
                    itemBuilder: (context, index) {
                      final item = _furniture[index];
                      return _FurnitureCard(
                        furniture: item,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VisualizationPreviewPage(
                                fabric: widget.fabric,
                                furniture: item,
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

class _FurnitureCard extends StatelessWidget {
  final FurnitureModel furniture;
  final VoidCallback onTap;

  const _FurnitureCard({required this.furniture, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.network(
                furniture.angleImageUrls.first,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.beige,
                    child: Icon(
                      furniture.typeString == 'curtain'
                          ? Icons.window
                          : Icons.weekend,
                      size: 64.sp,
                      color: AppColors.textTertiary,
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(AppDimensions.spacing16),
              color: AppColors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    furniture.name,
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    furniture.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
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

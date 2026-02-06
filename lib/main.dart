import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:showroom/core/navigation/main_navigation.dart';
import 'package:showroom/core/theme/app_theme.dart';

// BLoCs
import 'package:showroom/features/catalog/presentation/bloc/catalog_bloc.dart';
import 'package:showroom/features/selection/presentation/bloc/furniture_bloc.dart';
import 'package:showroom/features/preview/presentation/bloc/visualization_bloc.dart';

// Repositories
import 'package:showroom/features/catalog/data/repositories/fabric_repository_impl.dart';
import 'package:showroom/features/selection/data/repositories/furniture_repository_impl.dart';
import 'package:showroom/features/preview/data/repositories/visualization_repository_impl.dart';

// Datasources
import 'package:showroom/features/catalog/data/datasources/fabric_remote_datasource.dart';
import 'package:showroom/features/selection/data/datasources/furniture_remote_datasource.dart';

// Use Cases
import 'package:showroom/features/catalog/domain/usecases/get_fabrics.dart';
import 'package:showroom/features/catalog/domain/usecases/filter_fabrics.dart';
import 'package:showroom/features/selection/domain/usecases/get_furniture.dart';
import 'package:showroom/features/preview/domain/usecases/save_visualization.dart';
import 'package:showroom/features/preview/domain/usecases/get_recent_visualizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize repositories
    final fabricRepository = FabricRepositoryImpl(
      remoteDataSource: FabricRemoteDataSourceImpl(),
    );

    final furnitureRepository = FurnitureRepositoryImpl(
      remoteDataSource: FurnitureRemoteDataSourceImpl(),
    );

    final visualizationRepository = VisualizationRepositoryImpl();

    return ScreenUtilInit(
      designSize: const Size(1280, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            // Catalog BLoC
            BlocProvider<CatalogBloc>(
              create: (context) => CatalogBloc(
                getFabrics: GetFabrics(fabricRepository),
                filterFabrics: FilterFabrics(fabricRepository),
              )..add(const LoadFabricsEvent()),
            ),

            // Furniture BLoC
            BlocProvider<FurnitureBloc>(
              create: (context) => FurnitureBloc(
                getFurniture: GetFurniture(furnitureRepository),
              ),
            ),

            // Visualization BLoC
            BlocProvider<VisualizationBloc>(
              create: (context) => VisualizationBloc(
                saveVisualization: SaveVisualization(visualizationRepository),
                getRecentVisualizations:
                    GetRecentVisualizations(visualizationRepository),
              ),
            ),
          ],
          child: MaterialApp(
            title: 'Premium Fabric Showroom',
            theme: AppTheme.lightTheme,
            debugShowCheckedModeBanner: false,
            home: const MainNavigation(),
          ),
        );
      },
    );
  }
}

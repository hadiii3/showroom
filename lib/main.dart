import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:showroom/core/theme/app_theme.dart';
import 'package:showroom/core/navigation/main_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Future: Initialize Hive for local caching
  // await Hive.initFlutter();
  // await Hive.registerAdapter(FabricModelAdapter());
  // await Hive.registerAdapter(FurnitureModelAdapter());
  // await Hive.registerAdapter(VisualizationModelAdapter());

  runApp(const ShowroomApp());
}

class ShowroomApp extends StatelessWidget {
  const ShowroomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1024, 768), // Tablet design size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Premium Fabric Showroom',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          home: const MainNavigation(),
        );
      },
    );
  }
}

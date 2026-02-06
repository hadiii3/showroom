import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:showroom/core/constants/app_colors.dart';
import 'package:showroom/core/constants/app_dimensions.dart';
import 'package:showroom/features/preview/presentation/bloc/visualization_bloc.dart';
import 'package:showroom/features/preview/presentation/bloc/visualization_event.dart';
import 'package:showroom/features/preview/presentation/bloc/visualization_state.dart';

class RecentVisualizationsPage extends StatefulWidget {
  const RecentVisualizationsPage({super.key});

  @override
  State<RecentVisualizationsPage> createState() =>
      _RecentVisualizationsPageState();
}

class _RecentVisualizationsPageState extends State<RecentVisualizationsPage> {
  @override
  void initState() {
    super.initState();
    // Load recent visualizations when page loads
    context
        .read<VisualizationBloc>()
        .add(const LoadRecentVisualizationsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recent Visualizations'),
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<VisualizationBloc, VisualizationState>(
        builder: (context, state) {
          if (state is RecentVisualizationsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is RecentVisualizationsError) {
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
                      context.read<VisualizationBloc>().add(
                            const LoadRecentVisualizationsEvent(),
                          );
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is RecentVisualizationsLoaded) {
            if (state.visualizations.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.history,
                      size: 64.sp,
                      color: AppColors.textTertiary,
                    ),
                    SizedBox(height: AppDimensions.spacing16),
                    Text(
                      'No recent visualizations',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: AppDimensions.spacing8),
                    Text(
                      'Your saved visualizations will appear here',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textTertiary,
                          ),
                    ),
                  ],
                ),
              );
            }

            return GridView.builder(
              padding: EdgeInsets.all(AppDimensions.spacing24),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.75,
                crossAxisSpacing: AppDimensions.spacing24,
                mainAxisSpacing: AppDimensions.spacing24,
              ),
              itemCount: state.visualizations.length,
              itemBuilder: (context, index) {
                final visualization = state.visualizations[index];
                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  NetworkImage(visualization.compositeImageUrl),
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
                              visualization.fabricName,
                              style: Theme.of(context).textTheme.titleMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              visualization.furnitureName,
                              style: Theme.of(context).textTheme.bodySmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }

          // Initial state - show loading
          if (state is VisualizationInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

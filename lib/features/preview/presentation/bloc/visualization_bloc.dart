import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showroom/features/preview/domain/usecases/get_recent_visualizations.dart';
import 'package:showroom/features/preview/domain/usecases/save_visualization.dart';
import 'package:showroom/features/preview/presentation/bloc/visualization_event.dart';
import 'package:showroom/features/preview/presentation/bloc/visualization_state.dart';

class VisualizationBloc extends Bloc<VisualizationEvent, VisualizationState> {
  final SaveVisualization saveVisualization;
  final GetRecentVisualizations getRecentVisualizations;

  VisualizationBloc({
    required this.saveVisualization,
    required this.getRecentVisualizations,
  }) : super(const VisualizationInitial()) {
    on<SaveVisualizationEvent>(_onSaveVisualization);
    on<LoadRecentVisualizationsEvent>(_onLoadRecentVisualizations);
    on<DeleteVisualizationEvent>(_onDeleteVisualization);
  }

  Future<void> _onSaveVisualization(
    SaveVisualizationEvent event,
    Emitter<VisualizationState> emit,
  ) async {
    emit(const VisualizationSaving());

    final result = await saveVisualization(event.visualization);

    result.fold(
      (failure) =>
          emit(const VisualizationError('Failed to save visualization')),
      (visualization) => emit(VisualizationSaved(visualization)),
    );
  }

  Future<void> _onLoadRecentVisualizations(
    LoadRecentVisualizationsEvent event,
    Emitter<VisualizationState> emit,
  ) async {
    emit(const RecentVisualizationsLoading());

    final result = await getRecentVisualizations();

    result.fold(
      (failure) => emit(const RecentVisualizationsError(
          'Failed to load recent visualizations')),
      (visualizations) => emit(RecentVisualizationsLoaded(visualizations)),
    );
  }

  Future<void> _onDeleteVisualization(
    DeleteVisualizationEvent event,
    Emitter<VisualizationState> emit,
  ) async {
    // Reload after delete
    add(const LoadRecentVisualizationsEvent());
  }
}

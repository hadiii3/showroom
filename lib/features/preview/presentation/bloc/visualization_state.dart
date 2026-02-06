import 'package:equatable/equatable.dart';
import 'package:showroom/features/preview/domain/entities/visualization.dart';

abstract class VisualizationState extends Equatable {
  const VisualizationState();

  @override
  List<Object?> get props => [];
}

class VisualizationInitial extends VisualizationState {
  const VisualizationInitial();
}

class VisualizationSaving extends VisualizationState {
  const VisualizationSaving();
}

class VisualizationSaved extends VisualizationState {
  final Visualization visualization;

  const VisualizationSaved(this.visualization);

  @override
  List<Object?> get props => [visualization];
}

class VisualizationError extends VisualizationState {
  final String message;

  const VisualizationError(this.message);

  @override
  List<Object?> get props => [message];
}

class RecentVisualizationsLoading extends VisualizationState {
  const RecentVisualizationsLoading();
}

class RecentVisualizationsLoaded extends VisualizationState {
  final List<Visualization> visualizations;

  const RecentVisualizationsLoaded(this.visualizations);

  @override
  List<Object?> get props => [visualizations];
}

class RecentVisualizationsError extends VisualizationState {
  final String message;

  const RecentVisualizationsError(this.message);

  @override
  List<Object?> get props => [message];
}

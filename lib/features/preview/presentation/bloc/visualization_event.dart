import 'package:equatable/equatable.dart';
import 'package:showroom/features/preview/domain/entities/visualization.dart';

abstract class VisualizationEvent extends Equatable {
  const VisualizationEvent();

  @override
  List<Object?> get props => [];
}

class SaveVisualizationEvent extends VisualizationEvent {
  final Visualization visualization;

  const SaveVisualizationEvent(this.visualization);

  @override
  List<Object?> get props => [visualization];
}

class LoadRecentVisualizationsEvent extends VisualizationEvent {
  const LoadRecentVisualizationsEvent();
}

class DeleteVisualizationEvent extends VisualizationEvent {
  final String visualizationId;

  const DeleteVisualizationEvent(this.visualizationId);

  @override
  List<Object?> get props => [visualizationId];
}

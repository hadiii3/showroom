import 'package:dartz/dartz.dart';
import 'package:showroom/core/errors/failures.dart';
import 'package:showroom/features/preview/domain/entities/visualization.dart';

abstract class VisualizationRepository {
  Future<Either<Failure, Visualization>> saveVisualization(
      Visualization visualization);
  Future<Either<Failure, List<Visualization>>> getRecentVisualizations();
  Future<Either<Failure, void>> deleteVisualization(String visualizationId);
}

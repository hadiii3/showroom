import 'package:dartz/dartz.dart';
import 'package:showroom/core/errors/failures.dart';
import 'package:showroom/features/preview/domain/entities/visualization.dart';
import 'package:showroom/features/preview/domain/repositories/visualization_repository.dart';

class SaveVisualization {
  final VisualizationRepository repository;

  SaveVisualization(this.repository);

  Future<Either<Failure, Visualization>> call(
      Visualization visualization) async {
    return await repository.saveVisualization(visualization);
  }
}

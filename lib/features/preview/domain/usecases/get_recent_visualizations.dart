import 'package:dartz/dartz.dart';
import 'package:showroom/core/errors/failures.dart';
import 'package:showroom/features/preview/domain/entities/visualization.dart';
import 'package:showroom/features/preview/domain/repositories/visualization_repository.dart';

class GetRecentVisualizations {
  final VisualizationRepository repository;

  GetRecentVisualizations(this.repository);

  Future<Either<Failure, List<Visualization>>> call() async {
    return await repository.getRecentVisualizations();
  }
}

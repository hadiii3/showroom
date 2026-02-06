import 'package:dartz/dartz.dart';
import 'package:showroom/core/errors/failures.dart';
import 'package:showroom/features/preview/domain/entities/visualization.dart';
import 'package:showroom/features/preview/domain/repositories/visualization_repository.dart';
import 'package:uuid/uuid.dart';

class VisualizationRepositoryImpl implements VisualizationRepository {
  // For now, use in-memory storage (will be replaced with Firebase/Hive later)
  final List<Visualization> _savedVisualizations = [];
  final _uuid = const Uuid();

  @override
  Future<Either<Failure, Visualization>> saveVisualization(
      Visualization visualization) async {
    try {
      // Create a new visualization with an ID if it doesn't have one
      final savedVisualization = Visualization(
        id: visualization.id.isEmpty ? _uuid.v4() : visualization.id,
        fabricId: visualization.fabricId,
        furnitureId: visualization.furnitureId,
        fabricName: visualization.fabricName,
        furnitureName: visualization.furnitureName,
        compositeImageUrl: visualization.compositeImageUrl,
        createdAt: DateTime.now(),
      );

      // Add to in-memory list
      _savedVisualizations.insert(0, savedVisualization);

      return Right(savedVisualization);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Visualization>>> getRecentVisualizations() async {
    try {
      // Return a copy of the list, sorted by createdAt (newest first)
      final sorted = List<Visualization>.from(_savedVisualizations)
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

      return Right(sorted);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteVisualization(
      String visualizationId) async {
    try {
      _savedVisualizations.removeWhere((v) => v.id == visualizationId);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}

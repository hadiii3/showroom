import 'package:dartz/dartz.dart';
import 'package:showroom/core/errors/exceptions.dart';
import 'package:showroom/core/errors/failures.dart';
import 'package:showroom/features/selection/data/datasources/furniture_remote_datasource.dart';
import 'package:showroom/features/selection/domain/entities/furniture.dart';
import 'package:showroom/features/selection/domain/repositories/furniture_repository.dart';

class FurnitureRepositoryImpl implements FurnitureRepository {
  final FurnitureRemoteDataSource remoteDataSource;

  FurnitureRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<Furniture>>> getFurniture(
      String furnitureType) async {
    try {
      final furniture =
          await remoteDataSource.getFurnitureByType(furnitureType);
      return Right(furniture);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}

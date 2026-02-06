import 'package:dartz/dartz.dart';
import 'package:showroom/core/errors/exceptions.dart';
import 'package:showroom/core/errors/failures.dart';
import 'package:showroom/features/catalog/data/datasources/fabric_remote_datasource.dart';
import 'package:showroom/features/catalog/domain/entities/fabric.dart';
import 'package:showroom/features/catalog/domain/repositories/fabric_repository.dart';

class FabricRepositoryImpl implements FabricRepository {
  final FabricRemoteDataSource remoteDataSource;

  FabricRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<Fabric>>> getAllFabrics() async {
    try {
      final fabrics = await remoteDataSource.getAllFabrics();
      return Right(fabrics);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Fabric>>> filterFabrics({
    String? color,
    String? material,
  }) async {
    try {
      final allFabrics = await remoteDataSource.getAllFabrics();

      final filtered = allFabrics.where((fabric) {
        bool matchesColor = color == null || fabric.color == color;
        bool matchesMaterial = material == null || fabric.material == material;
        return matchesColor && matchesMaterial;
      }).toList();

      return Right(filtered);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}

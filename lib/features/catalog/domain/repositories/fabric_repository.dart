import 'package:showroom/core/errors/failures.dart';
import 'package:showroom/features/catalog/domain/entities/fabric.dart';
import 'package:dartz/dartz.dart';

abstract class FabricRepository {
  Future<Either<Failure, List<Fabric>>> getAllFabrics();
  Future<Either<Failure, List<Fabric>>> filterFabrics({
    String? color,
    String? material,
  });
}

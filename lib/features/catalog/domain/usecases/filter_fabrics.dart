import 'package:dartz/dartz.dart';
import 'package:showroom/core/errors/failures.dart';
import 'package:showroom/features/catalog/domain/entities/fabric.dart';
import 'package:showroom/features/catalog/domain/repositories/fabric_repository.dart';

class FilterFabrics {
  final FabricRepository repository;

  FilterFabrics(this.repository);

  Future<Either<Failure, List<Fabric>>> call({
    String? color,
    String? material,
  }) async {
    return await repository.filterFabrics(
      color: color,
      material: material,
    );
  }
}

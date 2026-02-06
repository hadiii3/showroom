import 'package:dartz/dartz.dart';
import 'package:showroom/core/errors/failures.dart';
import 'package:showroom/features/catalog/domain/entities/fabric.dart';
import 'package:showroom/features/catalog/domain/repositories/fabric_repository.dart';

class GetFabrics {
  final FabricRepository repository;

  GetFabrics(this.repository);

  Future<Either<Failure, List<Fabric>>> call() async {
    return await repository.getAllFabrics();
  }
}

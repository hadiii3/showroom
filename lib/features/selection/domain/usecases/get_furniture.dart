import 'package:dartz/dartz.dart';
import 'package:showroom/core/errors/failures.dart';
import 'package:showroom/features/selection/domain/entities/furniture.dart';
import 'package:showroom/features/selection/domain/repositories/furniture_repository.dart';

class GetFurniture {
  final FurnitureRepository repository;

  GetFurniture(this.repository);

  Future<Either<Failure, List<Furniture>>> call(String furnitureType) async {
    return await repository.getFurniture(furnitureType);
  }
}

import 'package:dartz/dartz.dart';
import 'package:showroom/core/errors/failures.dart';
import 'package:showroom/features/selection/domain/entities/furniture.dart';

abstract class FurnitureRepository {
  Future<Either<Failure, List<Furniture>>> getFurniture(String furnitureType);
}

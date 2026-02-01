import 'package:equatable/equatable.dart';
import 'package:showroom/features/catalog/domain/entities/fabric.dart';
import 'package:showroom/features/selection/domain/entities/furniture.dart';

/// Domain entity for saved visualization
class Visualization extends Equatable {
  final String id;
  final Fabric fabric;
  final Furniture furniture;
  final DateTime timestamp;

  const Visualization({
    required this.id,
    required this.fabric,
    required this.furniture,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [id, fabric, furniture, timestamp];
}

import 'package:equatable/equatable.dart';

abstract class FurnitureEvent extends Equatable {
  const FurnitureEvent();

  @override
  List<Object?> get props => [];
}

class LoadFurnitureEvent extends FurnitureEvent {
  final String furnitureType;

  const LoadFurnitureEvent(this.furnitureType);

  @override
  List<Object?> get props => [furnitureType];
}

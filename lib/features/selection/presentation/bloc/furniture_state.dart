import 'package:equatable/equatable.dart';
import 'package:showroom/features/selection/domain/entities/furniture.dart';

abstract class FurnitureState extends Equatable {
  const FurnitureState();

  @override
  List<Object?> get props => [];
}

class FurnitureInitial extends FurnitureState {
  const FurnitureInitial();
}

class FurnitureLoading extends FurnitureState {
  const FurnitureLoading();
}

class FurnitureLoaded extends FurnitureState {
  final List<Furniture> furniture;
  final String furnitureType;

  const FurnitureLoaded({
    required this.furniture,
    required this.furnitureType,
  });

  @override
  List<Object?> get props => [furniture, furnitureType];
}

class FurnitureError extends FurnitureState {
  final String message;

  const FurnitureError(this.message);

  @override
  List<Object?> get props => [message];
}

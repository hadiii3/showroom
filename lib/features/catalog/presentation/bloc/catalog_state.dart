import 'package:equatable/equatable.dart';
import 'package:showroom/features/catalog/domain/entities/fabric.dart';

abstract class CatalogState extends Equatable {
  const CatalogState();

  @override
  List<Object?> get props => [];
}

class CatalogInitial extends CatalogState {
  const CatalogInitial();
}

class CatalogLoading extends CatalogState {
  const CatalogLoading();
}

class CatalogLoaded extends CatalogState {
  final List<Fabric> fabrics;
  final List<Fabric> filteredFabrics;
  final String? selectedColor;
  final String? selectedMaterial;

  const CatalogLoaded({
    required this.fabrics,
    required this.filteredFabrics,
    this.selectedColor,
    this.selectedMaterial,
  });

  @override
  List<Object?> get props =>
      [fabrics, filteredFabrics, selectedColor, selectedMaterial];

  CatalogLoaded copyWith({
    List<Fabric>? fabrics,
    List<Fabric>? filteredFabrics,
    String? selectedColor,
    String? selectedMaterial,
    bool clearColor = false,
    bool clearMaterial = false,
  }) {
    return CatalogLoaded(
      fabrics: fabrics ?? this.fabrics,
      filteredFabrics: filteredFabrics ?? this.filteredFabrics,
      selectedColor: clearColor ? null : (selectedColor ?? this.selectedColor),
      selectedMaterial:
          clearMaterial ? null : (selectedMaterial ?? this.selectedMaterial),
    );
  }
}

class CatalogError extends CatalogState {
  final String message;

  const CatalogError(this.message);

  @override
  List<Object?> get props => [message];
}

import 'package:equatable/equatable.dart';

abstract class CatalogEvent extends Equatable {
  const CatalogEvent();

  @override
  List<Object?> get props => [];
}

class LoadFabricsEvent extends CatalogEvent {
  const LoadFabricsEvent();
}

class FilterFabricsEvent extends CatalogEvent {
  final String? color;
  final String? material;

  const FilterFabricsEvent({
    this.color,
    this.material,
  });

  @override
  List<Object?> get props => [color, material];
}

class ClearFiltersEvent extends CatalogEvent {
  const ClearFiltersEvent();
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showroom/features/catalog/domain/usecases/filter_fabrics.dart';
import 'package:showroom/features/catalog/domain/usecases/get_fabrics.dart';
import 'package:showroom/features/catalog/presentation/bloc/catalog_event.dart';
import 'package:showroom/features/catalog/presentation/bloc/catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  final GetFabrics getFabrics;
  final FilterFabrics filterFabrics;

  CatalogBloc({
    required this.getFabrics,
    required this.filterFabrics,
  }) : super(const CatalogInitial()) {
    on<LoadFabricsEvent>(_onLoadFabrics);
    on<FilterFabricsEvent>(_onFilterFabrics);
    on<ClearFiltersEvent>(_onClearFilters);
  }

  Future<void> _onLoadFabrics(
    LoadFabricsEvent event,
    Emitter<CatalogState> emit,
  ) async {
    emit(const CatalogLoading());

    final result = await getFabrics();

    result.fold(
      (failure) => emit(const CatalogError('Failed to load fabrics')),
      (fabrics) => emit(CatalogLoaded(
        fabrics: fabrics,
        filteredFabrics: fabrics,
      )),
    );
  }

  Future<void> _onFilterFabrics(
    FilterFabricsEvent event,
    Emitter<CatalogState> emit,
  ) async {
    if (state is CatalogLoaded) {
      final currentState = state as CatalogLoaded;

      final result = await filterFabrics(
        color: event.color,
        material: event.material,
      );

      result.fold(
        (failure) => emit(const CatalogError('Failed to filter fabrics')),
        (filtered) => emit(currentState.copyWith(
          filteredFabrics: filtered,
          selectedColor: event.color,
          selectedMaterial: event.material,
        )),
      );
    }
  }

  Future<void> _onClearFilters(
    ClearFiltersEvent event,
    Emitter<CatalogState> emit,
  ) async {
    if (state is CatalogLoaded) {
      final currentState = state as CatalogLoaded;
      emit(currentState.copyWith(
        filteredFabrics: currentState.fabrics,
        clearColor: true,
        clearMaterial: true,
      ));
    }
  }
}

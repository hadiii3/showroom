import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showroom/features/selection/domain/usecases/get_furniture.dart';
import 'package:showroom/features/selection/presentation/bloc/furniture_event.dart';
import 'package:showroom/features/selection/presentation/bloc/furniture_state.dart';

class FurnitureBloc extends Bloc<FurnitureEvent, FurnitureState> {
  final GetFurniture getFurniture;

  FurnitureBloc({
    required this.getFurniture,
  }) : super(const FurnitureInitial()) {
    on<LoadFurnitureEvent>(_onLoadFurniture);
  }

  Future<void> _onLoadFurniture(
    LoadFurnitureEvent event,
    Emitter<FurnitureState> emit,
  ) async {
    emit(const FurnitureLoading());

    final result = await getFurniture(event.furnitureType);

    result.fold(
      (failure) => emit(const FurnitureError('Failed to load furniture')),
      (furniture) => emit(FurnitureLoaded(
        furniture: furniture,
        furnitureType: event.furnitureType,
      )),
    );
  }
}

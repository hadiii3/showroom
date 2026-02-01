import 'package:showroom/features/catalog/data/models/fabric_model.dart';
import 'package:showroom/features/selection/data/models/furniture_model.dart';
import 'package:showroom/features/preview/domain/entities/visualization.dart';

class VisualizationModel extends Visualization {
  @override
  final String id;

  final FabricModel fabricModel;

  final FurnitureModel furnitureModel;

  final int timestampMillis;

  VisualizationModel({
    required this.id,
    required this.fabricModel,
    required this.furnitureModel,
    required this.timestampMillis,
  }) : super(
         id: id,
         fabric: fabricModel,
         furniture: furnitureModel,
         timestamp: DateTime.fromMillisecondsSinceEpoch(timestampMillis),
       );

  // Create from entity
  factory VisualizationModel.fromEntity(Visualization visualization) {
    return VisualizationModel(
      id: visualization.id,
      fabricModel: FabricModel.fromEntity(visualization.fabric),
      furnitureModel: FurnitureModel.fromEntity(visualization.furniture),
      timestampMillis: visualization.timestamp.millisecondsSinceEpoch,
    );
  }

  // Create from fabric and furniture
  factory VisualizationModel.create({
    required String id,
    required FabricModel fabric,
    required FurnitureModel furniture,
  }) {
    return VisualizationModel(
      id: id,
      fabricModel: fabric,
      furnitureModel: furniture,
      timestampMillis: DateTime.now().millisecondsSinceEpoch,
    );
  }
}

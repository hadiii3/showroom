import 'package:showroom/features/selection/domain/entities/furniture.dart';

class FurnitureModel extends Furniture {
  const FurnitureModel({
    required super.id,
    required super.name,
    required super.type,
    required super.style,
    required super.imageUrl,
    required super.description,
  });

  // JSON serialization
  factory FurnitureModel.fromJson(Map<String, dynamic> json) {
    return FurnitureModel(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      style: json['style'] as String,
      imageUrl: json['imageUrl'] as String,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'style': style,
      'imageUrl': imageUrl,
      'description': description,
    };
  }

  // No need for fromEntity - Model extends Entity so they're already compatible
}

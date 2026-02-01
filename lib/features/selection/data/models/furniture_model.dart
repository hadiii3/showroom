import 'package:showroom/features/selection/domain/entities/furniture.dart';

class FurnitureModel extends Furniture {
  @override
  final String id;

  @override
  final String name;

  @override
  final String description;

  final String typeString; // Store as string for serialization

  @override
  final List<String> angleImageUrls;

  @override
  final String? category;

  const FurnitureModel({
    required this.id,
    required this.name,
    required this.description,
    required this.typeString,
    required this.angleImageUrls,
    this.category,
  }) : super(
         id: id,
         name: name,
         description: description,
         type: typeString == 'couch'
             ? FurnitureType.couch
             : FurnitureType.curtain,
         angleImageUrls: angleImageUrls,
         category: category,
       );

  // JSON serialization
  factory FurnitureModel.fromJson(Map<String, dynamic> json) {
    return FurnitureModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      typeString: json['type'] as String,
      angleImageUrls: List<String>.from(json['angleImageUrls'] as List),
      category: json['category'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'type': typeString,
      'angleImageUrls': angleImageUrls,
      'category': category,
    };
  }

  // Create from entity
  factory FurnitureModel.fromEntity(Furniture furniture) {
    return FurnitureModel(
      id: furniture.id,
      name: furniture.name,
      description: furniture.description,
      typeString: furniture.type == FurnitureType.couch ? 'couch' : 'curtain',
      angleImageUrls: furniture.angleImageUrls,
      category: furniture.category,
    );
  }
}

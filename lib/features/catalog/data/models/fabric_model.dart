import 'package:showroom/features/catalog/domain/entities/fabric.dart';

class FabricModel extends Fabric {
  @override
  final String id;

  @override
  final String name;

  @override
  final String description;

  @override
  final double pricePerYard;

  @override
  final String composition;

  @override
  final int durability;

  @override
  final String origin;

  @override
  final List<String> careInstructions;

  @override
  final String color;

  @override
  final String material;

  @override
  final String pattern;

  @override
  final String imageUrl;

  @override
  final String closeUpImageUrl;

  const FabricModel({
    required this.id,
    required this.name,
    required this.description,
    required this.pricePerYard,
    required this.composition,
    required this.durability,
    required this.origin,
    required this.careInstructions,
    required this.color,
    required this.material,
    required this.pattern,
    required this.imageUrl,
    required this.closeUpImageUrl,
  }) : super(
         id: id,
         name: name,
         description: description,
         pricePerYard: pricePerYard,
         composition: composition,
         durability: durability,
         origin: origin,
         careInstructions: careInstructions,
         color: color,
         material: material,
         pattern: pattern,
         imageUrl: imageUrl,
         closeUpImageUrl: closeUpImageUrl,
       );

  // JSON serialization
  factory FabricModel.fromJson(Map<String, dynamic> json) {
    return FabricModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      pricePerYard: (json['pricePerYard'] as num).toDouble(),
      composition: json['composition'] as String,
      durability: json['durability'] as int,
      origin: json['origin'] as String,
      careInstructions: List<String>.from(json['careInstructions'] as List),
      color: json['color'] as String,
      material: json['material'] as String,
      pattern: json['pattern'] as String,
      imageUrl: json['imageUrl'] as String,
      closeUpImageUrl: json['closeUpImageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'pricePerYard': pricePerYard,
      'composition': composition,
      'durability': durability,
      'origin': origin,
      'careInstructions': careInstructions,
      'color': color,
      'material': material,
      'pattern': pattern,
      'imageUrl': imageUrl,
      'closeUpImageUrl': closeUpImageUrl,
    };
  }

  // Create from entity
  factory FabricModel.fromEntity(Fabric fabric) {
    return FabricModel(
      id: fabric.id,
      name: fabric.name,
      description: fabric.description,
      pricePerYard: fabric.pricePerYard,
      composition: fabric.composition,
      durability: fabric.durability,
      origin: fabric.origin,
      careInstructions: fabric.careInstructions,
      color: fabric.color,
      material: fabric.material,
      pattern: fabric.pattern,
      imageUrl: fabric.imageUrl,
      closeUpImageUrl: fabric.closeUpImageUrl,
    );
  }
}

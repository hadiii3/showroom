import 'package:equatable/equatable.dart';

/// Domain entity for fabric
class Fabric extends Equatable {
  final String id;
  final String name;
  final String description;
  final double pricePerYard;
  final String composition;
  final int durability; // Martindale score
  final String origin;
  final List<String> careInstructions;
  final String color;
  final String material;
  final String pattern;
  final String imageUrl;
  final String closeUpImageUrl;

  const Fabric({
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
  });

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    pricePerYard,
    composition,
    durability,
    origin,
    careInstructions,
    color,
    material,
    pattern,
    imageUrl,
    closeUpImageUrl,
  ];
}

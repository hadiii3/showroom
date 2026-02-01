import 'package:equatable/equatable.dart';

enum FurnitureType { couch, curtain }

/// Domain entity for furniture (couch or curtain)
class Furniture extends Equatable {
  final String id;
  final String name;
  final String description;
  final FurnitureType type;
  final List<String> angleImageUrls;
  final String? category; // e.g., "modern", "classic"

  const Furniture({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.angleImageUrls,
    this.category,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    type,
    angleImageUrls,
    category,
  ];
}

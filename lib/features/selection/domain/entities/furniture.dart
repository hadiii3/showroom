import 'package:equatable/equatable.dart';

/// Domain entity for furniture
class Furniture extends Equatable {
  final String id;
  final String name;
  final String type; // 'curtain' or 'couch'
  final String style;
  final String imageUrl;
  final String description;

  const Furniture({
    required this.id,
    required this.name,
    required this.type,
    required this.style,
    required this.imageUrl,
    required this.description,
  });

  @override
    name,
    description,
    type,
    angleImageUrls,
    category,
  ];
}

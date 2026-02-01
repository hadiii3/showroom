import 'package:showroom/features/selection/data/models/furniture_model.dart';

/// Remote datasource for furniture (Firebase)
abstract class FurnitureRemoteDataSource {
  Future<List<FurnitureModel>> getAllFurniture();
  Future<List<FurnitureModel>> getFurnitureByType(String type);
}

/// Mock implementation
class FurnitureRemoteDataSourceImpl implements FurnitureRemoteDataSource {
  @override
  Future<List<FurnitureModel>> getAllFurniture() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockFurniture;
  }

  @override
  Future<List<FurnitureModel>> getFurnitureByType(String type) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockFurniture.where((f) => f.typeString == type).toList();
  }
}

// Mock furniture data
final List<FurnitureModel> _mockFurniture = [
  // Curtains
  const FurnitureModel(
    id: 'curtain_001',
    name: 'Sheer',
    description: 'Light & Airy',
    typeString: 'curtain',
    angleImageUrls: [
      'https://images.unsplash.com/photo-1603794067602-9feaa4f70e0c?w=800',
      'https://images.unsplash.com/photo-1603794067602-9feaa4f70e0c?w=800',
      'https://images.unsplash.com/photo-1603794067602-9feaa4f70e0c?w=800',
    ],
    category: 'light',
  ),
  const FurnitureModel(
    id: 'curtain_002',
    name: 'Pleated',
    description: 'Classic & Structured',
    typeString: 'curtain',
    angleImageUrls: [
      'https://images.unsplash.com/photo-1593359677879-a4bb92f829d1?w=800',
      'https://images.unsplash.com/photo-1593359677879-a4bb92f829d1?w=800',
      'https://images.unsplash.com/photo-1593359677879-a4bb92f829d1?w=800',
    ],
    category: 'classic',
  ),
  const FurnitureModel(
    id: 'curtain_003',
    name: 'Blackout',
    description: 'Complete Privacy',
    typeString: 'curtain',
    angleImageUrls: [
      'https://images.unsplash.com/photo-1567225591450-75aa0fc4f2ad?w=800',
      'https://images.unsplash.com/photo-1567225591450-75aa0fc4f2ad?w=800',
      'https://images.unsplash.com/photo-1567225591450-75aa0fc4f2ad?w=800',
    ],
    category: 'privacy',
  ),

  // Couches
  const FurnitureModel(
    id: 'couch_001',
    name: 'Modern Sofa',
    description: 'Clean lines & minimalism',
    typeString: 'couch',
    angleImageUrls: [
      'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=800',
      'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=800',
      'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=800',
    ],
    category: 'modern',
  ),
  const FurnitureModel(
    id: 'couch_002',
    name: 'Classic Chesterfield',
    description: 'Timeless tufted elegance',
    typeString: 'couch',
    angleImageUrls: [
      'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=800',
      'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=800',
      'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=800',
    ],
    category: 'classic',
  ),
  const FurnitureModel(
    id: 'couch_003',
    name: 'L-Shape Sectional',
    description: 'Spacious family seating',
    typeString: 'couch',
    angleImageUrls: [
      'https://images.unsplash.com/photo-1567016432779-094069958ea5?w=800',
      'https://images.unsplash.com/photo-1567016432779-094069958ea5?w=800',
      'https://images.unsplash.com/photo-1567016432779-094069958ea5?w=800',
    ],
    category: 'modern',
  ),
  const FurnitureModel(
    id: 'couch_004',
    name: 'Cozy Loveseat',
    description: 'Compact comfort',
    typeString: 'couch',
    angleImageUrls: [
      'https://images.unsplash.com/photo-1550254478-ead40cc54513?w=800',
      'https://images.unsplash.com/photo-1550254478-ead40cc54513?w=800',
      'https://images.unsplash.com/photo-1550254478-ead40cc54513?w=800',
    ],
    category: 'compact',
  ),
  const FurnitureModel(
    id: 'couch_005',
    name: 'Designer Daybed',
    description: 'Versatile & lounging',
    typeString: 'couch',
    angleImageUrls: [
      'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?w=800',
      'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?w=800',
      'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?w=800',
    ],
    category: 'designer',
  ),
];

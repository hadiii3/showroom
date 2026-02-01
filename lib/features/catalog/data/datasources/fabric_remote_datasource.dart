import 'package:showroom/features/catalog/data/models/fabric_model.dart';

/// Remote datasource interface for fabrics (Firebase)
abstract class FabricRemoteDataSource {
  Future<List<FabricModel>> getAllFabrics();
  Future<FabricModel> getFabricById(String id);
}

/// Mock implementation until Firebase is configured
class FabricRemoteDataSourceImpl implements FabricRemoteDataSource {
  @override
  Future<List<FabricModel>> getAllFabrics() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    return _mockFabrics;
  }

  @override
  Future<FabricModel> getFabricById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));

    return _mockFabrics.firstWhere((fabric) => fabric.id == id);
  }
}

// Mock fabric data
final List<FabricModel> _mockFabrics = [
  const FabricModel(
    id: 'fabric_001',
    name: 'Venetian Linen',
    description:
        'A premium, lightweight linen with a soft, breathable texture. Perfect for any drapes or refined upholstery that demands an organic touch.',
    pricePerYard: 85.0,
    composition: '100% Belgian Flax',
    durability: 25000,
    origin: 'Italy',
    careInstructions: ['no-iron', 'dry-clean', 'cold-water'],
    color: 'neutral',
    material: 'linen',
    pattern: 'solid',
    imageUrl:
        'https://images.unsplash.com/photo-1585846416120-3a7354ed7d39?w=400',
    closeUpImageUrl:
        'https://images.unsplash.com/photo-1585846416120-3a7354ed7d39?w=800',
  ),
  const FabricModel(
    id: 'fabric_002',
    name: 'Midnight Velvet',
    description:
        'Luxurious deep pile velvet with rich color depth and premium hand feel. Ideal for statement pieces.',
    pricePerYard: 120.0,
    composition: '100% Cotton',
    durability: 30000,
    origin: 'France',
    careInstructions: ['dry-clean-only', 'no-direct-sun'],
    color: 'blue',
    material: 'velvet',
    pattern: 'solid',
    imageUrl:
        'https://images.unsplash.com/photo-1518199266791-5375a83190b7?w=400',
    closeUpImageUrl:
        'https://images.unsplash.com/photo-1518199266791-5375a83190b7?w=800',
  ),
  const FabricModel(
    id: 'fabric_003',
    name: 'Sahara Chenille',
    description:
        'Soft, textured chenille in warm desert tones. Durable and family-friendly.',
    pricePerYard: 95.0,
    composition: '85% Polyester, 15% Cotton',
    durability: 40000,
    origin: 'USA',
    careInstructions: ['machine-washable', 'tumble-dry-low'],
    color: 'beige',
    material: 'chenille',
    pattern: 'solid',
    imageUrl:
        'https://images.unsplash.com/photo-1604762512326-f3958b08e8d8?w=400',
    closeUpImageUrl:
        'https://images.unsplash.com/photo-1604762512326-f3958b08e8d8?w=800',
  ),
  const FabricModel(
    id: 'fabric_004',
    name: 'Botanical Jacquard',
    description:
        'Intricate woven botanical pattern with metallic threads. Statement textile for luxury interiors.',
    pricePerYard: 150.0,
    composition: '70% Silk, 30% Metallic Thread',
    durability: 20000,
    origin: 'India',
    careInstructions: ['dry-clean-only', 'professional-care'],
    color: 'green',
    material: 'silk',
    pattern: 'pattern',
    imageUrl:
        'https://images.unsplash.com/photo-1615799780765-c6d72e3a1d9f?w=400',
    closeUpImageUrl:
        'https://images.unsplash.com/photo-1615799780765-c6d72e3a1d9f?w=800',
  ),
  const FabricModel(
    id: 'fabric_005',
    name: 'Cloud Silk',
    description:
        'Whisper-soft silk blend with ethereal drape. Perfect for flowing curtains.',
    pricePerYard: 110.0,
    composition: '80% Silk, 20% Cotton',
    durability: 18000,
    origin: 'China',
    careInstructions: ['dry-clean', 'gentle-cycle'],
    color: 'white',
    material: 'silk',
    pattern: 'solid',
    imageUrl:
        'https://images.unsplash.com/photo-1562582553-0724-4c28-94a3-63fb81fc623b?w=400',
    closeUpImageUrl:
        'https://images.unsplash.com/photo-1562582553-0724-4c28-94a3-63fb81fc623b?w=800',
  ),
  const FabricModel(
    id: 'fabric_006',
    name: 'Graphite Wool',
    description:
        'Premium wool blend in sophisticated charcoal. Modern and timeless.',
    pricePerYard: 135.0,
    composition: '90% Wool, 10% Nylon',
    durability: 35000,
    origin: 'Scotland',
    careInstructions: ['dry-clean-only'],
    color: 'gray',
    material: 'wool',
    pattern: 'solid',
    imageUrl:
        'https://images.unsplash.com/photo-1570733577125-0a3f1bcb2a47?w=400',
    closeUpImageUrl:
        'https://images.unsplash.com/photo-1570733577125-0a3f1bcb2a47?w=800',
  ),
  const FabricModel(
    id: 'fabric_007',
    name: 'Terracotta Twill',
    description:
        'Earthy terracotta in structured twill weave. Bold and contemporary.',
    pricePerYard: 78.0,
    composition: '100% Cotton',
    durability: 28000,
    origin: 'Portugal',
    careInstructions: ['machine-washable', 'iron-medium'],
    color: 'orange',
    material: 'cotton',
    pattern: 'solid',
    imageUrl:
        'https://images.unsplash.com/photo-1580982172477-56e0e87be8b4?w=400',
    closeUpImageUrl:
        'https://images.unsplash.com/photo-1580982172477-56e0e87be8b4?w=800',
  ),
  const FabricModel(
    id: 'fabric_008',
    name: 'Emerald Boucle',
    description:
        'Textured boucle in rich emerald green. Adds depth and visual interest.',
    pricePerYard: 105.0,
    composition: '60% Wool, 40% Acrylic',
    durability: 32000,
    origin: 'Belgium',
    careInstructions: ['dry-clean', 'professional-care'],
    color: 'green',
    material: 'wool',
    pattern: 'textured',
    imageUrl:
        'https://images.unsplash.com/photo-1601925653158-2b6c1be82770?w=400',
    closeUpImageUrl:
        'https://images.unsplash.com/photo-1601925653158-2b6c1be82770?w=800',
  ),
];

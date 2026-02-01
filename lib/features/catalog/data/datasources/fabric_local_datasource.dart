import 'package:showroom/features/catalog/data/models/fabric_model.dart';

/// Local datasource for fabric caching
/// Note: Hive integration removed for static UI version
abstract class FabricLocalDataSource {
  Future<List<FabricModel>> getCachedFabrics();
  Future<void> cacheFabrics(List<FabricModel> fabrics);
  Future<List<FabricModel>> filterFabrics({
    String? color,
    String? material,
    String? pattern,
  });
}

/// Implementation using in-memory storage for demo
class FabricLocalDataSourceImpl implements FabricLocalDataSource {
  // In-memory cache for demo
  List<FabricModel> _cachedFabrics = [];

  @override
  Future<List<FabricModel>> getCachedFabrics() async {
    return _cachedFabrics;
  }

  @override
  Future<void> cacheFabrics(List<FabricModel> fabrics) async {
    _cachedFabrics = fabrics;
  }

  @override
  Future<List<FabricModel>> filterFabrics({
    String? color,
    String? material,
    String? pattern,
  }) async {
    var fabrics = _cachedFabrics;

    if (color != null && color.isNotEmpty) {
      fabrics = fabrics
          .where((f) => f.color.toLowerCase() == color.toLowerCase())
          .toList();
    }

    if (material != null && material.isNotEmpty) {
      fabrics = fabrics
          .where((f) => f.material.toLowerCase() == material.toLowerCase())
          .toList();
    }

    if (pattern != null && pattern.isNotEmpty) {
      fabrics = fabrics
          .where((f) => f.pattern.toLowerCase() == pattern.toLowerCase())
          .toList();
    }

    return fabrics;
  }
}

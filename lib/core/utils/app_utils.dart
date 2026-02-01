/// Collection of reusable utility functions
class AppUtils {
  AppUtils._();

  /// Format price with currency symbol
  static String formatPrice(double price) {
    return '\$${price.toStringAsFixed(2)}';
  }

  /// Format durability score
  static String formatDurability(int rubs) {
    if (rubs >= 30000) return 'Heavy Duty';
    if (rubs >= 20000) return 'Medium';
    return 'Light Use';
  }

  /// Capitalize first letter
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  /// Format care instruction text
  static String formatCareInstruction(String instruction) {
    return instruction
        .replaceAll('-', ' ')
        .split(' ')
        .map(capitalize)
        .join(' ');
  }
}

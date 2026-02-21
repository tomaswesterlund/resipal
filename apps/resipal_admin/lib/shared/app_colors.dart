import 'package:flutter/material.dart';
import 'package:resipal_core/presentation/shared/colors/base_app_colors.dart';

class AppColors extends BaseAppColors {
  // Brand Primary: RGB(53, 129, 184)
  static const Color primary = Color(0xFF3581B8);

  // Brand Secondary (Often a complementary or accent color)
  static const Color secondary = Color(0xFF1A4644); // Keeping your previous brand teal

  // Semantic Colors
  static const Color success = Color(0xFF2ECC71);
  static const Color danger = Color(0xFFE74C3C);
  static const Color warning = Color(0xFFF1C40F);
  static const Color info = Color(0xFF3498DB);

  // Neutral Scale
  static const Color background = Color(0xFFF8FAFB);
  static const Color surface = Colors.white;

  /// Custom scale for text and borders
  static const Map<int, Color> grayscale = {
    50: Color(0xFFF9FAFB),
    100: Color(0xFFF3F4F6),
    200: Color(0xFFE5E7EB),
    300: Color(0xFFD1D5DB),
    400: Color(0xFF9CA3AF),
    500: Color(0xFF6B7280),
    600: Color(0xFF4B5563),
    700: Color(0xFF374151),
    800: Color(0xFF1F2937),
    900: Color(0xFF111827),
  };
}

import 'package:flutter/material.dart';

class AppColors {
  // --- Brand Colors ---
  static const Color primary = Color(0xFF3581B8);
  static const Color secondary = Color(0xFF455A64);

  /// Primary Scale (Blue) - From light background tint to deep navy
  static const Map<int, Color> primaryScale = {
    50: Color(0xFFF2F7FB),
    100: Color(0xFFE1EDF6),
    200: Color(0xFFC2DBED),
    300: Color(0xFF91BFE0),
    400: Color(0xFF5F9FD0),
    500: Color(0xFF3581B8), // Primary Base
    600: Color(0xFF2A6793),
    700: Color(0xFF204D6E),
    800: Color(0xFF15344A),
    900: Color(0xFF0A1A25),
  };

  /// Secondary Scale (Slate Blue-Grey) - Based on 0xFF455A64
  static const Map<int, Color> secondaryScale = {
    50: Color(0xFFECEFF1), // Very light wash for surfaces
    100: Color(0xFFCFD8DC), // Soft borders
    200: Color(0xFFB0BEC5), // Disabled elements
    300: Color(0xFF90A4AE), // Helper text
    400: Color(0xFF78909C), // Secondary icons
    500: Color(0xFF455A64), // Secondary Base (The color you provided)
    600: Color(0xFF37474F), // Hover states
    700: Color(0xFF263238), // Dark headings
    800: Color(0xFF1B2429), // Deep contrast
    900: Color(0xFF101619), // Near black
  };

  static const Color auxiliarBase = Color(0xFF5C6661); // From shade 500
  static const Map<int, Color> auxiliarScale = {
    900: Color(0xFF1D2120),
    800: Color(0xFF2D3331),
    700: Color(0xFF3D4441),
    600: Color(0xFF4C5551),
    500: Color(0xFF5C6661), // Auxiliar 'A'
    400: Color(0xFF7E8984),
    300: Color(0xFFA1ABA7),
    200: Color(0xFFC1C8C5),
    100: Color(0xFFE2E5E4),
    50: Color(0xFFF4F5F4),
  };

  // --- Semantic Colors ---
  static const Color success = Color(0xFF2ECC71);
  static const Color danger = Color(0xFFE74C3C);
  static const Color warning = Color(0xFFF1C40F);
  static const Color info = Color(0xFF3498DB);

  // --- Neutral & Surface ---
  static const Color background = Color.fromARGB(255, 242, 246, 247);
  static const Color surface = Colors.white;

  /// Grayscale for general text and borders
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

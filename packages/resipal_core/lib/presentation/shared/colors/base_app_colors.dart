import 'package:flutter/material.dart';

class BaseAppColors {

  // --- Primary Scale (Orange) ---
  static const Color primaryBase = Color(0xFFF6751A); // From shade 500
  static const Map<int, Color> primaryScale = {
    900: Color(0xFF853204),
    800: Color(0xFFA14107),
    700: Color(0xFFBD510B),
    600: Color(0xFFD96210),
    500: Color(0xFFF6751A), // Primary 'P'
    400: Color(0xFFFF8947),
    300: Color(0xFFFFA775),
    200: Color(0xFFFFC5A3),
    100: Color(0xFFFFE2D1),
    50: Color(0xFFFFF4ED),
  };

  // --- Secondary Scale (Teal/Dark Green) ---
  static const Color secondaryBase = Color(0xFF002C2A); // From shade 700
  static const Map<int, Color> secondaryScale = {
    900: Color(0xFF00100F),
    800: Color(0xFF001F1E),
    700: Color(0xFF002C2A), // Secondary 'S'
    600: Color(0xFF0D3E3B),
    500: Color(0xFF1A514D),
    400: Color(0xFF477571),
    300: Color(0xFF759895),
    200: Color(0xFFA3BCBA),
    100: Color(0xFFD1DFDE),
    50: Color(0xFFF2F7F7),
  };

  // --- Auxiliar Scale (Grays) ---
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

  static const Color successBase = Color(0xFF22C574); // From shade 500
  static const Map<int, Color> successScale = {
    900: Color(0xFF0D4B2D),
    800: Color(0xFF14683E),
    700: Color(0xFF1A854F),
    600: Color(0xFF1EB36A),
    500: Color(0xFF22C574), // successBase
    400: Color(0xFF55D595),
    300: Color(0xFF88E5B6),
    200: Color(0xFFBBF5D7),
    100: Color(0xFFDEFCEF),
    50: Color(0xFFF0FDF4),
  };

  // --- Danger Scale (Reds) ---
  static const Color dangerBase = Color(0xFFEB5857); // From shade 500
  static const Map<int, Color> dangerScale = {
    900: Color(0xFF5C1A1A),
    800: Color(0xFF7D2424),
    700: Color(0xFFA12F2E),
    600: Color(0xFFC63E3D),
    500: Color(0xFFEB5857), // Danger 'D'
    400: Color(0xFFEF7A79),
    300: Color(0xFFF39C9B),
    200: Color(0xFFF7BDBC),
    100: Color(0xFFFBDEDE),
    50: Color(0xFFFEF2F2),
  };

  // --- Warning Scale (Reds) ---
  static const Color warningBase = Color(0xFFF99C16);
  static const Map<int, Color> warningScale = {
    900: Color(0xFF7C4D0B),
    800: Color(0xFF955D0D),
    700: Color(0xFFB3700F),
    600: Color(0xFFD18212),
    500: Color(0xFFF99C16), // warningBase
    400: Color(0xFFFBAF45),
    300: Color(0xFFFDC373),
    200: Color(0xFFFED7A2),
    100: Color(0xFFFFEBD0),
    50: Color(0xFFFFF7ED),
  };

  // --- Semantic Aliases ---
  static const Color primary = primaryBase;
  static const Color secondary = secondaryBase;
  static const Color background = Color(0xFFF2F7F7);
  static const Color surface = Colors.white;

  // Status colors as defined in the second design sheet
  static const Color success = successBase;
  static const Color warning = warningBase;
  static const Color danger = dangerBase;
  static const Color info = Color(0xFF759895);

  // Example shades for UI elements
  static const Color fieldBorder = Color(0xFFD1DFDE); // Secondary 100
  static const Color hintText = Color(0xFFA1ABA7); // Auxiliar 300

}

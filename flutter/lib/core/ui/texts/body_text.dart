import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BodyText extends StatelessWidget {
  final String text;
  final double fontSize;
  final double lineHeight;
  final FontWeight fontWeight;
  final Color color;

  const BodyText({
    super.key,
    required this.text,
    this.fontSize = 16.0,
    this.lineHeight = 1.5,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.black,
  });

  const BodyText.large(
    this.text, {
    this.color = Colors.black,
    this.fontWeight = FontWeight.normal,
    super.key,
  })  : fontSize = 18.0,
        lineHeight = 28.0 / 18.0; // 28PX LINE

  const BodyText.medium(
    this.text, {
    this.color = Colors.black,
    this.fontWeight = FontWeight.normal,
    super.key,
  })  : fontSize = 16.0,
        lineHeight = 24.0 / 16.0; // 24PX LINE

  const BodyText.small(
    this.text, {
    this.color = Colors.black,
    this.fontWeight = FontWeight.normal,
    super.key,
  })  : fontSize = 14.0,
        lineHeight = 20.0 / 14.0; // 20PX LINE

  const BodyText.tiny(
    this.text, {
    this.color = Colors.black,
    this.fontWeight = FontWeight.normal,
    super.key,
  })  : fontSize = 12.0,
        lineHeight = 16.0 / 12.0; // 16PX LINE

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.raleway(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: lineHeight, // Line height in Flutter is a multiplier of fontSize
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;

  const HeaderText({
    super.key,
    required this.text,
    this.fontSize = 18.0,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.black,
  });

  const HeaderText.one(
    this.text, {
    this.color = Colors.black,
    this.fontWeight = FontWeight.bold,
    super.key,
  }) : fontSize = 32.0;

  const HeaderText.two(
    this.text, {
    this.color = Colors.black,
    this.fontWeight = FontWeight.bold,
    super.key,
  }) : fontSize = 24.0;

  const HeaderText.three(
    this.text, {
    this.color = Colors.black,
    this.fontWeight = FontWeight.bold,
    super.key,
  }) : fontSize = 20.0;

  const HeaderText.four(
    this.text, {
    this.color = Colors.black,
    this.fontWeight = FontWeight.bold,
    super.key,
  }) : fontSize = 18.0;

  const HeaderText.five(
    this.text, {
    this.color = Colors.black,
    this.fontWeight = FontWeight.bold,
    super.key,
  }) : fontSize = 16.0;

  const HeaderText.six(
    this.text, {
    this.color = Colors.black,
    this.fontWeight = FontWeight.bold,
    super.key,
  }) : fontSize = 14.0;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.raleway(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}

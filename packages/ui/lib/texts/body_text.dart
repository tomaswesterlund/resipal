import 'package:flutter/material.dart';

class BodyText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final Color? color;
  final int? maxLines; // Nuevo
  final TextOverflow? overflow; // Nuevo

  const BodyText(
    this.text, {
    super.key,
    this.style,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  /// Body Large: 18PX / 28PX LINE
  factory BodyText.large(
    String text, {
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    Key? key,
  }) =>
      BodyText(
        text,
        key: key,
        textAlign: textAlign,
        color: color,
        maxLines: maxLines,
        overflow: overflow,
        style: TextStyle(
          fontSize: 18,
          height: 28 / 18,
          fontWeight: fontWeight ?? FontWeight.normal,
        ),
      );

  /// Body Medium: 16PX / 24PX LINE
  factory BodyText.medium(
    String text, {
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    Key? key,
  }) =>
      BodyText(
        text,
        key: key,
        textAlign: textAlign,
        color: color,
        maxLines: maxLines,
        overflow: overflow,
        style: TextStyle(
          fontSize: 16,
          height: 24 / 16,
          fontWeight: fontWeight ?? FontWeight.normal,
        ),
      );

  /// Body Small: 14PX / 20PX LINE
  factory BodyText.small(
    String text, {
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    Key? key,
  }) =>
      BodyText(
        text,
        key: key,
        textAlign: textAlign,
        color: color,
        maxLines: maxLines,
        overflow: overflow,
        style: TextStyle(
          fontSize: 14,
          height: 20 / 14,
          fontWeight: fontWeight ?? FontWeight.normal,
        ),
      );

  /// Caption / Tiny: 12PX / 16PX LINE
  factory BodyText.tiny(
    String text, {
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    Key? key,
  }) =>
      BodyText(
        text,
        key: key,
        textAlign: textAlign,
        color: color,
        maxLines: maxLines,
        overflow: overflow,
        style: TextStyle(
          fontSize: 12,
          height: 16 / 12,
          fontWeight: fontWeight ?? FontWeight.normal,
          fontFamily: 'Poppins', 
        ),
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: style?.copyWith(
        color: color ?? theme.textTheme.bodyMedium?.color,
        fontFamily: style?.fontFamily ?? theme.textTheme.bodyMedium?.fontFamily,
      ),
    );
  }
}
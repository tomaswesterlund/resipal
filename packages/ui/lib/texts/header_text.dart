import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final Color? color;
  final int? maxLines; // Nuevo
  final TextOverflow? overflow; // Nuevo

  const HeaderText(
    this.text, {
    super.key,
    this.style,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  /// GIGA: 48PX / 54 LINE
  factory HeaderText.giga(String text, {Color? color, TextAlign? textAlign, int? maxLines, TextOverflow? overflow, Key? key}) => HeaderText(
    text,
    key: key,
    textAlign: textAlign,
    color: color,
    maxLines: maxLines,
    overflow: overflow,
    style: const TextStyle(
      fontSize: 48,
      height: 54 / 48,
      fontWeight: FontWeight.w900,
    ),
  );

  /// H1: 32PX / 40PX LINE
  factory HeaderText.one(String text, {Color? color, TextAlign? textAlign, int? maxLines, TextOverflow? overflow, Key? key}) => HeaderText(
    text,
    key: key,
    textAlign: textAlign,
    color: color,
    maxLines: maxLines,
    overflow: overflow,
    style: const TextStyle(fontSize: 32, height: 40 / 32, fontWeight: FontWeight.bold),
  );

  /// H2: 24PX / 32PX LINE
  factory HeaderText.two(String text, {Color? color, TextAlign? textAlign, int? maxLines, TextOverflow? overflow, Key? key}) => HeaderText(
    text,
    key: key,
    textAlign: textAlign,
    color: color,
    maxLines: maxLines,
    overflow: overflow,
    style: const TextStyle(fontSize: 24, height: 32 / 24, fontWeight: FontWeight.bold),
  );

  /// H3: 20PX / 28PX LINE
  factory HeaderText.three(String text, {Color? color, TextAlign? textAlign, int? maxLines, TextOverflow? overflow, Key? key}) => HeaderText(
    text,
    key: key,
    textAlign: textAlign,
    color: color,
    maxLines: maxLines,
    overflow: overflow,
    style: const TextStyle(fontSize: 20, height: 28 / 20, fontWeight: FontWeight.bold),
  );

  /// H4: 18PX / 24 LINE
  factory HeaderText.four(String text, {Color? color, TextAlign? textAlign, int? maxLines, TextOverflow? overflow, Key? key}) => HeaderText(
    text,
    key: key,
    textAlign: textAlign,
    color: color,
    maxLines: maxLines,
    overflow: overflow,
    style: const TextStyle(fontSize: 18, height: 24 / 18, fontWeight: FontWeight.bold),
  );

  /// H5: 16PX / 20 LINE
  factory HeaderText.five(String text, {Color? color, TextAlign? textAlign, int? maxLines, TextOverflow? overflow, Key? key}) => HeaderText(
    text,
    key: key,
    textAlign: textAlign,
    color: color,
    maxLines: maxLines,
    overflow: overflow,
    style: const TextStyle(fontSize: 16, height: 20 / 16, fontWeight: FontWeight.bold),
  );

  /// H6: 14PX / 16 LINE
  factory HeaderText.six(String text, {Color? color, TextAlign? textAlign, int? maxLines, TextOverflow? overflow, Key? key}) => HeaderText(
    text,
    key: key,
    textAlign: textAlign,
    color: color,
    maxLines: maxLines,
    overflow: overflow,
    style: const TextStyle(fontSize: 14, height: 16 / 14, fontWeight: FontWeight.bold),
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
        color: color ?? theme.textTheme.bodyLarge?.color,
        fontFamily: theme.textTheme.displayLarge?.fontFamily,
      ),
    );
  }
}
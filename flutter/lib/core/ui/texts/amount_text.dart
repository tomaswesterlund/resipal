import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resipal/core/formatters/currency_formatter.dart';

class AmountText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;

  const AmountText(this.text, {this.fontSize = 48.0, this.color = Colors.black, super.key});

  AmountText.fromDouble(double amount, {this.fontSize = 48.0, this.color = Colors.black, super.key}) : text = CurrencyFormatter.toCurrencyString(amount);
  AmountText.fromInt(int amount, {this.fontSize = 48.0, this.color = Colors.black, super.key}) : text = CurrencyFormatter.toCurrencyString(amount.toDouble());

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.notoSansMono(
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

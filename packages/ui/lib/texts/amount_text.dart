import 'package:flutter/material.dart';
import 'package:ui/extensions/formatters/currency_formatter.dart';

class AmountText extends StatelessWidget {
  final int amountInCents;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign? textAlign;
  final Color? color; // Nuevo campo opcional

  const AmountText({
    required this.amountInCents,
    this.fontSize = 48.0,
    this.fontWeight = FontWeight.bold,
    this.textAlign,
    this.color, // Incluido en el constructor
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // El color proporcionado tiene prioridad absoluta.
    // Si es null, se aplica la lógica basada en el monto.
    final Color effectiveColor =
        color ??
        (amountInCents > 0
            ? Colors.green
            : amountInCents < 0
            ? Colors.red
            : Colors.black);

    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: textAlign == TextAlign.center ? Alignment.center : Alignment.centerLeft,
      child: Text(
        CurrencyFormatter.fromCents(amountInCents),
        textAlign: textAlign,
        style: TextStyle(color: effectiveColor, fontSize: fontSize, fontWeight: fontWeight, fontFamily: 'NotoSansMono'),
      ),
    );
  }
}

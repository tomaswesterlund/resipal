import 'package:intl/intl.dart';

class CurrencyFormatter {
  static String fromDouble(double value) {
    final formatter = NumberFormat(r"$###.00", 'es_MX');
    return formatter.format(value);
  }

  static String fromCents(int amountInCents) {
    final double amount = amountInCents / 100.0;
    final formatter = NumberFormat.simpleCurrency(locale: 'es_MX');
    return formatter.format(amount);
  }

  static int toAmountInCents(double value) {
    return (value * 100).round();
  }
}

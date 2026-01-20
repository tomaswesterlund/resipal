import 'package:intl/intl.dart';

class CurrencyFormatter {
  static String toCurrencyString(double value) {
    final formatter = NumberFormat(r"$###.00", 'es_MX');
    return formatter.format(value);
  }
}

import 'package:intl/intl.dart';

extension DateFormatters on DateTime {
  String toShortDate() {
    final formatter = DateFormat.yMMMMd();
    return formatter.format(this);
  }
}

import 'package:intl/intl.dart';

extension DateFormatters on DateTime {
  String toShortDate({bool showYear = true}) {
    final local = toLocal();
    if (showYear) {
      return DateFormat('dd MMM').format(local);
    } else {
      return DateFormat('dd MMM, yyyy').format(local);
    }
  }

  static String toDateRange(DateTime fromDate, DateTime toDate) {
    final DateTime now = DateTime.now();
    final DateTime from = fromDate.toLocal();
    final DateTime to = toDate.toLocal();

    if (from.year == to.year && from.month == to.month && from.day == to.day) {
      if (from.year == now.year) {
        return from.toShortDate();
      } else {
        return DateFormat('dd MMM').format(from);
      }
    } else {
      final showYear = (now.year == to.year) == true;
      return '${from.toShortDate(showYear: showYear)} - ${to.toShortDate(showYear: showYear)}';
    }
  }
}

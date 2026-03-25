import 'package:intl/intl.dart';

extension DateFormatters on DateTime {
  String toShortDate({bool showYear = true}) {
    if (showYear) {
      final DateFormat formatter = DateFormat('dd MMM');
      return formatter.format(this);
    } else {
      final DateFormat formatter = DateFormat('dd MMM, yyyy');
      return formatter.format(this);
    }
  }

  static String toDateRange(DateTime fromDate, DateTime toDate) {
    final DateTime now = DateTime.now();

    if (fromDate.year == toDate.year && fromDate.month == toDate.month && fromDate.day == toDate.day) {
      if (fromDate.year == now.year) {
        return fromDate.toShortDate();
      } else {
        return DateFormat('dd MMM').format(fromDate);
      }
    } else {
      final showYear = (now.year == toDate.year) == true;
      return '${fromDate.toShortDate(showYear: showYear)} - ${toDate.toShortDate(showYear: showYear)}';
    }
  }
}

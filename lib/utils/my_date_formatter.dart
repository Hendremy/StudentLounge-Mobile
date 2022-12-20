import 'package:intl/intl.dart';

class MyDateFormatter {
  static String formatDateYMMMD(DateTime date) {
    var formatter = DateFormat.yMMMMd(('fr_FR'));
    return formatter.format(date).toString();
  }

  static String formatHours(DateTime date) {
    var formatter = DateFormat.Hm();
    return formatter.format(date).toString();
  }
}

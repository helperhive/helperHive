import 'package:intl/intl.dart';

class DateTimeManager {
  String get_date_in_days() {
    String cdate1 = DateFormat("EEEEE, dd, yyyy").format(DateTime.now());
    return cdate1;
  }

  String get_date_in_digits() {
    String cdate = DateFormat("yyyy-MM-dd").format(DateTime.now());
    return cdate;
  }

  String formatDateTime(DateTime dateTime) {
    final dateFormat = DateFormat('h:mm a');
    return dateFormat.format(dateTime);
  }
}

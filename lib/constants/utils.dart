import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class DateTimeManager {
  static String getDateInDays() {
    String cdate1 = DateFormat("EEEEE, dd, yyyy").format(DateTime.now());
    return cdate1;
  }

  static String getDateInDigits() {
    String cdate = DateFormat("yyyy-MM-dd").format(DateTime.now());
    return cdate;
  }

  static String formatDateTime(DateTime dateTime) {
    final dateFormat = DateFormat('h:mm a');
    return dateFormat.format(dateTime);
  }

  static String convertTime(TimeOfDay time) {
    final currentDate = DateTime.now();
    final date = DateTime(currentDate.year, currentDate.month, currentDate.day,
        time.hour, time.minute);

    return Jiffy.parseFromDateTime(date).format(pattern: 'hh:mm aa');
  }

  static String convertDate(DateTime dateTime) {
    return Jiffy.parseFromDateTime(dateTime).format(pattern: 'dd MMM yyyy');
  }

  static DateTime convertToDate(String dateString) {
    return DateFormat('dd MMM yyyy').parse(dateString);
  }
}

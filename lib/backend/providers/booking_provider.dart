import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingProvider extends ChangeNotifier {
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now();
  CalendarFormat _format = CalendarFormat.week;

  DateTime get selectedDate => _selectedDate;

  DateTime get focusedDate => _focusedDate;

  CalendarFormat get format => _format;

  bool isSelected = true;
  void isSelectedDateOk(DateTime selectedDay, DateTime focusedDay) {
    if (selectedDay
        .isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
      isSelected = false;
    } else {
      isSelected = true;
      _selectedDate = selectedDay;
      _focusedDate = focusedDay;
    }
    notifyListeners();
  }

  void setCalenderFormate() {
    if (format != CalendarFormat.month) {
      _format = CalendarFormat.month;
    } else {
      _format = CalendarFormat.week;
    }
    notifyListeners();
  }

  TimeOfDay _slotTime = const TimeOfDay(hour: 7, minute: 0);

  TimeOfDay get slotTime => _slotTime;
  TimeOfDay _alterSlotTime = const TimeOfDay(hour: 7, minute: 0);

  TimeOfDay get alternateSlotTime => _alterSlotTime;
  void slotTimeSelect(BuildContext context) async {
    _slotTime = await selectTime(context, slotTime);
  }

  void slotAlternateTimeSelect(BuildContext context) async {
    _alterSlotTime = await selectTime(context, slotTime);
  }

  Future<TimeOfDay> selectTime(BuildContext context, TimeOfDay time) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: time,
    );

    return newTime ?? const TimeOfDay(hour: 7, minute: 0);
  }
}

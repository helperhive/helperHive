import 'package:flutter/material.dart';
import 'package:helperhive/backend/firestore/firebase_firestore_methods.dart';
import 'package:helperhive/enums/issue_type.dart';
import 'package:helperhive/enums/service_enum.dart';
import 'package:helperhive/model/service_booking.dart';
import 'package:helperhive/model/service_person.dart';
import 'package:helperhive/model/user_model.dart';
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
        .isBefore(DateTime.now().subtract(const Duration(hours: 12)))) {
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

  TimeOfDay _slotTime = const TimeOfDay(hour: 5, minute: 0);

  TimeOfDay get slotTime => _slotTime;
  TimeOfDay _alterSlotTime = const TimeOfDay(hour: 7, minute: 0);

  TimeOfDay get alternateSlotTime => _alterSlotTime;
  Future<void> slotTimeSelect(BuildContext context) async {
    _slotTime = await selectTime(context, slotTime);

    notifyListeners();
  }

  void slotAlternateTimeSelect(BuildContext context) async {
    _alterSlotTime = await selectTime(context, slotTime);
    notifyListeners();
  }

  Future<TimeOfDay> selectTime(BuildContext context, TimeOfDay time) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: time,
    );

    return newTime ?? const TimeOfDay(hour: 7, minute: 0);
  }

  BookingMethods bookingMethods = BookingMethods();
  bool _isBooking = false;
  bool get isBooking => _isBooking;
  Future<String> completeBoooking({
    required ServicePerson servicePerson,
    required UserModel user,
    required String location,
    required String timeSlot,
    required String bookingDate,
    IssueType? issueType,
    String? alternateTimeSlot,
    String? note,
  }) async {
    String res = '';
    _isBooking = true;
    // print(isBooking);
    try {
      await completeWorkerBooking(
          name: user.name,
          workerUid: servicePerson.uid,
          location: location,
          service: servicePerson.service,
          timeSlot: timeSlot,
          bookingDate: bookingDate,
          alternateTimeSlot: alternateTimeSlot,
          note: note,
          issueType: issueType);
      await completeUserBooking(
          name: servicePerson.name,
          workerUid: servicePerson.uid,
          location: location,
          service: servicePerson.service,
          timeSlot: timeSlot,
          bookingDate: bookingDate,
          alternateTimeSlot: alternateTimeSlot,
          note: note,
          issueType: issueType);
      await Future.delayed(const Duration(seconds: 2));
      _isBooking = false;
      // print(isBooking);
      res = 'success';
      _alterSlotTime = const TimeOfDay(hour: 7, minute: 0);
      _selectedDate = DateTime.now();
      _slotTime = const TimeOfDay(hour: 5, minute: 0);
    } catch (e) {
      res = e.toString();
      throw Exception(e.toString());
    }
    notifyListeners();
    return res;
  }

  Future<void> completeWorkerBooking({
    required String name,
    required String workerUid,
    required String location,
    required Service service,
    required String timeSlot,
    required String bookingDate,
    IssueType? issueType,
    String? alternateTimeSlot,
    String? note,
  }) async {
    await bookingMethods.workerBooking(
        name: name,
        workerUid: workerUid,
        location: location,
        service: service,
        timeSlot: timeSlot,
        bookingDate: bookingDate,
        alternateTimeSlot: alternateTimeSlot,
        issueType: issueType,
        note: note);
  }

  Future<void> completeUserBooking({
    required String name,
    required String workerUid,
    required String location,
    required Service service,
    required String timeSlot,
    required String bookingDate,
    IssueType? issueType,
    String? alternateTimeSlot,
    String? note,
  }) async {
    await bookingMethods.userBooking(
        name: name,
        workerUid: workerUid,
        location: location,
        service: service,
        timeSlot: timeSlot,
        bookingDate: bookingDate,
        alternateTimeSlot: alternateTimeSlot,
        note: note,
        issueType: issueType);
  }
}

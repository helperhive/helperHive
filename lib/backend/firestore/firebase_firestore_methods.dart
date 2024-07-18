import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:helperhive/enums/issue_type.dart';
import 'package:helperhive/enums/service_enum.dart';
import 'package:helperhive/model/service_booking.dart';

class BookingMethods {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final User user = FirebaseAuth.instance.currentUser!;

  Future<void> workerBooking({
    required String name,
    required String workerUid,
    required String location,
    required Service service,
    required String timeSlot,
    required String bookingDate,
    required String phoneNumber,
    IssueType? issueType,
    String? alternateTimeSlot,
    String? note,
  }) async {
    try {
      ServiceBooking serviceBooking = ServiceBooking(
          name: name,
          uid: user.uid,
          service: service,
          bookingDate: bookingDate,
          location: location,
          timeSlot: timeSlot,
          phoneNumber: phoneNumber,
          alternateTimeSlot: alternateTimeSlot,
          note: note,
          issueType: issueType);
      await firebaseFirestore
          .collection('workers')
          .doc(workerUid)
          .collection('currentBookings')
          .add(serviceBooking.toMap());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> userBooking({
    required String name,
    required String workerUid,
    required String location,
    required Service service,
    required String timeSlot,
    required String bookingDate,
    required String phoneNumber,
    IssueType? issueType,
    String? alternateTimeSlot,
    String? note,
  }) async {
    try {
      ServiceBooking serviceBooking = ServiceBooking(
          name: name,
          uid: workerUid,
          service: service,
          bookingDate: bookingDate,
          location: location,
          timeSlot: timeSlot,
          phoneNumber: phoneNumber,
          alternateTimeSlot: alternateTimeSlot,
          note: note,
          issueType: issueType);
      await firebaseFirestore
          .collection('users')
          .doc(user.uid)
          .collection('myBookings')
          .add(serviceBooking.toMap());
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

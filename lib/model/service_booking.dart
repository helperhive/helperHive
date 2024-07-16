import 'package:helperhive/enums/service_enum.dart';

class ServiceBooking {
  final String name;
  final String uid;
  final Service service;
  final DateTime bookingDate;
  final String location;
  final String time;

  ServiceBooking(
      {required this.name,
      required this.uid,
      required this.service,
      required this.bookingDate,
      required this.location,
      required this.time});
}

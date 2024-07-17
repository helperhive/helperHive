// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helperhive/enums/issue_type.dart';
import 'package:helperhive/enums/service_enum.dart';

class ServiceBooking {
  final String name;
  final String uid;
  final Service service;
  final DateTime bookingDate;
  final String location;
  final Timestamp time;
  final IssueType issueType;
  final Timestamp? alternateTime;
  ServiceBooking(
      {required this.name,
      required this.uid,
      required this.service,
      required this.bookingDate,
      required this.location,
      required this.issueType,
      this.alternateTime,
      required this.time});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'service': service.toString(),
      'bookingDate': bookingDate.millisecondsSinceEpoch,
      'location': location,
      'time': time,
      'issueType': issueType,
      'alternateTime': alternateTime ?? '',
    };
  }

  static ServiceBooking fromSnapshot(DocumentSnapshot documentSnapshot) {
    var map = documentSnapshot.data() as Map<String, dynamic>;
    return ServiceBooking(
      name: map['name'] as String,
      uid: map['uid'] as String,
      service: stringToService(map['service']),
      bookingDate: map['bookingDate'],
      location: map['location'] as String,
      time: map['time'],
      issueType: stringToIssue(map['issueType']),
      alternateTime: map['alternateTime'],
    );
  }

  static Service stringToService(String service) {
    return Service.values.firstWhere((e) => e.toString() == service);
  }

  static IssueType stringToIssue(String issue) {
    return IssueType.values.firstWhere((e) => e.toString() == issue);
  }

  String toJson() => json.encode(toMap());
}

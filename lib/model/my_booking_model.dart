// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MyBooking {
  final String imageUrl;
  final String time;
  final String serviceName;
  final String price;
  final String providerName;
  final DateTime date;
  final bool isBooked;

  MyBooking(
      {required this.imageUrl,
      required this.time,
      required this.serviceName,
      required this.price,
      required this.providerName,
      required this.isBooked,
      required this.date});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imageUrl': imageUrl,
      'time': time,
      'serviceName': serviceName,
      'price': price,
      'providerName': providerName,
      'date': date.millisecondsSinceEpoch,
      'isBooked': isBooked,
    };
  }

  factory MyBooking.fromMap(Map<String, dynamic> map) {
    return MyBooking(
      imageUrl: map['imageUrl'] as String,
      time: map['time'] as String,
      serviceName: map['serviceName'] as String,
      price: map['price'] as String,
      providerName: map['providerName'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      isBooked: map['isBooked'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory MyBooking.fromJson(String source) =>
      MyBooking.fromMap(json.decode(source) as Map<String, dynamic>);
}

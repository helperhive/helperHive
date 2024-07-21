// ignore_for_file: constant_identifier_names

// import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helperhive/enums/service_enum.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String phoneNumber;
  final Service? service;
  final String? location; //required for the user ? remaining
  final double? rating;
  final double? experience;
  final Map? workingHours;
  final String? description;
  final String profileUrl;
  // final double discount;
  final double? price;
  final List connections;
  // final DateTime lastSeen;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.service,
    this.location,
    this.rating,
    this.experience,
    this.workingHours,
    this.description,
    required this.profileUrl,
    // required this.discount,
    this.price,
    required this.connections,
    // required this.lastSeen,
  });

  static UserModel fromSnapshot(DocumentSnapshot documentSnapshot) {
    var map = documentSnapshot.data() as Map<String, dynamic>;
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      service: map['service'] == null
          ? Service.user
          : stringToService(map['service']),
      location: map['location'],
      rating: map['rating'] ?? 0,
      experience: map['experience'] ?? 0,
      workingHours: map['workingHours'] ?? {},
      description: map['description'] ?? '',
      profileUrl: map['profileUrl'] == ''
          ? 'https://firebasestorage.googleapis.com/v0/b/helperhive-vishnu.appspot.com/o/profile.png?alt=media&token=873ed15e-cf9b-46e6-b03c-11499364f16f'
          : map['profileUrl'],
      // discount: map['discount'],
      price: map['price'] ?? 0,
      connections: map['connections'] ?? [],

      // lastSeen: map['lastSeen'],
    );
  }

  static Service stringToService(String service) {
    return Service.values.firstWhere((e) => e.toString() == service);
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'service': service.toString(),
      'location': location,
      'rating': rating,
      'experience': experience,
      'workingHours': workingHours,
      'description': description,
      'profileUrl': profileUrl,
      // 'discount': discount,
      'price': price,
      'connections': connections
      // 'lastSeen': lastSeen
    };
  }
}

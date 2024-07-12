// ignore_for_file: constant_identifier_names

// import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helperhive/enums/service_enum.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String phoneNumber;
  final Service service;
  final String location;
  final double rating;
  final int experience;
  final Map<String, String> workingHours;
  final String description;
  final String profileUrl;
  final double discount;
  final double price;
  final List<String> connections;
  // final DateTime lastSeen;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.service,
    required this.location,
    required this.rating,
    required this.experience,
    required this.workingHours,
    required this.description,
    required this.profileUrl,
    required this.discount,
    required this.price,
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
        service: stringToService(map['service']),
        location: map['location'],
        rating: map['rating'],
        experience: map['experience'],
        workingHours: Map<String, String>.from(map['workingHours']),
        description: map['description'],
        profileUrl: map['profileUrl'],
        discount: map['discount'],
        price: map['price'],
        connections: List<String>.from(
          (map['members'] as List<String>),
        )
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
      'discount': discount,
      'price': price,
      'connections': connections
      // 'lastSeen': lastSeen
    };
  }
}

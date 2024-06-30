// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

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
  final String imageUrl;
  final double discount;
  final double price;

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
    required this.imageUrl,
    required this.discount,
    required this.price,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
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
      imageUrl: map['imageUrl'],
      discount: map['discount'],
      price: map['price'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'service': service.toString().split('.').last,
      'location': location,
      'rating': rating,
      'experience': experience,
      'workingHours': workingHours,
      'description': description,
      'imageUrl': imageUrl,
      'discount': discount,
      'price': price,
    };
  }
}

enum Service {
  Cleaning,
  Washing,
  Repairs,
  Painting,
  Plumbing,
  Healthcare,
  Real_Estate,
  Transportation,
  Pest_Control,
  Saloon,
  Food_And_Beverage,
  Beauty_And_Spa,
  Others,
}

Service stringToService(String serviceString) {
  switch (serviceString) {
    case 'Cleaning':
      return Service.Cleaning;
    case 'Washing':
      return Service.Washing;
    case 'Repairs':
      return Service.Repairs;
    case 'Painting':
      return Service.Painting;
    case 'Plumbing':
      return Service.Plumbing;
    case 'Healthcare':
      return Service.Healthcare;
    case 'Real_Estate':
      return Service.Real_Estate;
    case 'Transportation':
      return Service.Transportation;
    case 'Pest_Control':
      return Service.Pest_Control;
    case 'Saloon':
      return Service.Saloon;
    case 'Food_And_Beverage':
      return Service.Food_And_Beverage;
    case 'Beauty_And_Spa':
      return Service.Beauty_And_Spa;
    case 'Others':
      return Service.Others;
    default:
      throw Exception('Invalid service string');
  }
}

IconData getIconForService(Service service) {
  switch (service) {
    case Service.Cleaning:
      return Icons.cleaning_services;
    case Service.Washing:
      return Icons.local_laundry_service;
    case Service.Repairs:
      return Icons.build;
    case Service.Painting:
      return Icons.format_paint;
    case Service.Plumbing:
      return Icons.plumbing;
    case Service.Healthcare:
      return Icons.local_hospital;
    case Service.Real_Estate:
      return Icons.home;
    case Service.Transportation:
      return Icons.directions_car;
    case Service.Pest_Control:
      return Icons.bug_report;
    case Service.Saloon:
      return Icons.content_cut;
    case Service.Food_And_Beverage:
      return Icons.local_dining;
    case Service.Beauty_And_Spa:
      return Icons.spa;
    case Service.Others:
      return const IconData(0xf7f4, fontFamily: 'MaterialIcons');
    default:
      throw Exception('Unexpected service: $service');
  }
}

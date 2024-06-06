import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String name;
  final String service;
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

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      name: json['name'],
      service: json['service'],
      location: json['location'],
      rating: json['rating'],
      experience: json['experience'],
      workingHours: Map<String, String>.from(json['workingHours']),
      description: json['description'],
      imageUrl: json['imageUrl'],
      discount: json['discount'],
      price: json['price'],
    );
  }

  factory UserModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id, // Use doc.id to get the document ID as the uid
      name: data['name'],
      service: data['service'],
      location: data['location'],
      rating: data['rating'],
      experience: data['experience'],
      workingHours: Map<String, String>.from(data['workingHours']),
      description: data['description'],
      imageUrl: data['imageUrl'],
      discount: data['discount'],
      price: data['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'service': service,
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

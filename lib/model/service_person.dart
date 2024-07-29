import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helperhive/enums/service_enum.dart';

class ServicePerson {
  final String uid;
  final String name;
  final String email;
  final String phoneNumber;
  final Service service;
  final String location;
  final double rating;
  final double experience;
  final Map workingHours;
  final String description;
  final String profileUrl;
  // final double discount;
  final double? price;
  final List connections;
  // final DateTime lastSeen;

  ServicePerson({
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
    // required this.discount,
    this.price,
    required this.connections,
    // required this.lastSeen,
  });

  static ServicePerson fromSnapshot(DocumentSnapshot documentSnapshot) {
    var map = documentSnapshot.data() as Map<String, dynamic>;

    return ServicePerson(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      service: map['service'] == null
          ? Service.others
          : stringToService(map['service']),
      location: map['location'] ?? '',
      rating: (map['rating'] ?? 0).toDouble(),
      experience: (map['experience'] ?? 0).toDouble(),
      workingHours: map['workingHours'] ?? {},
      description: map['description'] ?? '',
      profileUrl: map['profileUrl'] == ''
          ? 'https://firebasestorage.googleapis.com/v0/b/helperhive-vishnu.appspot.com/o/profile.png?alt=media&token=873ed15e-cf9b-46e6-b03c-11499364f16f'
          : map['profileUrl'],
      price: (map['price'] ?? 0).toDouble(),
      connections: map['connections'] ?? [],
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



// class ServicePerson {
//   final String profileUrl;
//   final String discount;
//   final double price;
//   final String name;
//   final int experience;
//   final double rating;
//   final Service service;
//   final Map workingHours;
//   ServicePerson({
//     required this.profileUrl,
//     required this.discount,
//     required this.price,
//     required this.name,
//     required this.experience,
//     required this.rating,
//     required this.service,
//     required this.workingHours,
//   });

//   // from Json from firestore
//   static ServicePerson fromSnapshot(DocumentSnapshot snapshot) {
//     final data = snapshot.data() as Map<String, dynamic>;
//     return ServicePerson(
//         profileUrl: data['profileUrl'] == ''
//             ? 'https://as2.ftcdn.net/v2/jpg/02/15/84/43/1000_F_215844325_ttX9YiIIyeaR7Ne6EaLLjMAmy4GvPC69.jpg'
//             : data['profileUrl'],
//         discount: data['discount'] ?? '',
//         price: data['price'] ?? 0,
//         name: data['name'],
//         experience: data['experience'] ?? 0,
//         rating: data['rating'].toDouble() ?? 0,
//         service: data['service'] == null
//             ? Service.user
//             : stringToService(data['service']),
//         workingHours: data['workingHours'] ?? {});
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'profileUrl': profileUrl,
//       'discount': discount,
//       'price': price,
//       'name': name,
//       'experience': experience,
//       'rating': rating.toDouble(),
//       'service': service.toString(),
//       'workingHours': workingHours,
//     };
//   }

//   static Service stringToService(String service) {
//     return Service.values.firstWhere((e) => e.toString() == service);
//   }
// }

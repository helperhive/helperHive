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

enum Service { service1, service2, service3, unknown }

Service stringToService(String serviceString) {
  switch (serviceString) {
    case 'service1':
      return Service.service1;
    case 'service2':
      return Service.service2;
    case 'service3':
      return Service.service3;
    default:
      throw Exception('Invalid service string');
  }
}

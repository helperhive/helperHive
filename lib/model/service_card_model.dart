import 'package:cloud_firestore/cloud_firestore.dart';

class ServicePersonData {
  final String imageUrl;
  final String discount;
  final String serviceName;
  final String price;
  final String providerName;
  final String experience;
  final double rating;

  ServicePersonData({
    required this.imageUrl,
    required this.discount,
    required this.serviceName,
    required this.price,
    required this.providerName,
    required this.experience,
    required this.rating,
  });

  factory ServicePersonData.fromJson(Map<String, dynamic> json) {
    return ServicePersonData(
      imageUrl: json['imageUrl'],
      discount: json['discount'],
      serviceName: json['serviceName'],
      price: json['price'],
      providerName: json['providerName'],
      experience: json['experience'],
      rating: json['rating'].toDouble(),
    );
  }

  // from Json from firestore
  factory ServicePersonData.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return ServicePersonData(
      imageUrl: data['imageUrl'],
      discount: data['discount'],
      serviceName: data['serviceName'],
      price: data['price'],
      providerName: data['providerName'],
      experience: data['experience'],
      rating: data['rating'].toDouble(),
    );
  }

  //  to convert  JSON map
  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'discount': discount,
      'serviceName': serviceName,
      'price': price,
      'providerName': providerName,
      'experience': experience,
      'rating': rating,
    };
  }

  static List<ServicePersonData> servicePersons = [
    ServicePersonData(
      imageUrl: "assets/services/repair_service.jpg",
      discount: '20',
      serviceName: 'Repair',
      price: '45',
      providerName: 'prakash',
      rating: 4.6,
      experience: '2',
    ),
    ServicePersonData(
      imageUrl: "assets/services/cleaning_service.jpg",
      discount: '15',
      serviceName: 'Cleaning',
      price: '25',
      providerName: 'Maria',
      rating: 4.4,
      experience: '2.5',
    ),
    ServicePersonData(
      imageUrl: "assets/services/washing_service.jpg",
      discount: '23',
      serviceName: 'Washing',
      price: '28',
      providerName: 'Vishnu',
      rating: 4.2,
      experience: '1.5',
    ),
    ServicePersonData(
      imageUrl: "assets/services/plumbing_service.jpg",
      discount: '15',
      serviceName: 'Plumbing',
      price: '35',
      providerName: 'Abhishek',
      rating: 4.1,
      experience: '1',
    ),
    ServicePersonData(
        imageUrl: "assets/services/painting_service.jpg",
        discount: '25',
        serviceName: 'Painting',
        price: '40',
        providerName: 'Venkat',
        rating: 4.2,
        experience: '1.6'),
    ServicePersonData(
        imageUrl: "assets/services/repair_service.jpg",
        discount: '20',
        serviceName: 'Repair',
        price: '45',
        providerName: 'prakash',
        rating: 4.6,
        experience: '1.8'),
    ServicePersonData(
        imageUrl: "assets/services/cleaning_service.jpg",
        discount: '15',
        serviceName: 'Cleaning',
        price: '25',
        providerName: 'Maria',
        rating: 4.4,
        experience: '2.5'),
    ServicePersonData(
        imageUrl: "assets/services/washing_service.jpg",
        discount: '23',
        serviceName: 'Washing',
        price: '28',
        providerName: 'Vishnu',
        rating: 4.2,
        experience: '3'),
    ServicePersonData(
        imageUrl: "assets/services/plumbing_service.jpg",
        discount: '15',
        serviceName: 'Plumbing',
        price: '35',
        providerName: 'Abhishek',
        rating: 4.1,
        experience: '3'),
    ServicePersonData(
        imageUrl: "assets/services/painting_service.jpg",
        discount: '25',
        serviceName: 'Painting',
        price: '40',
        providerName: 'Venkat',
        rating: 4.2,
        experience: '2.5'),
  ];
}

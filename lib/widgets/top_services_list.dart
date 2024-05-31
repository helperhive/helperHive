import 'package:flutter/material.dart';
import 'package:helperhive/widgets/service_card.dart';

class TopServicesList extends StatelessWidget {
  final int length;
  const TopServicesList({
    required this.length,
    super.key,
  });

  final List<ServiceCard> serviceCards = const [
    ServiceCard(
      imageUrl: "assets/services/repair_service.jpg",
      discount: '20',
      serviceName: 'Repair',
      price: '45',
      providerName: 'prakash',
      rating: 4.6,
    ),
    ServiceCard(
      imageUrl: "assets/services/cleaning_service.jpg",
      discount: '15',
      serviceName: 'Cleaning',
      price: '25',
      providerName: 'Maria',
      rating: 4.4,
    ),
    ServiceCard(
      imageUrl: "assets/services/washing_service.jpg",
      discount: '23',
      serviceName: 'Washing',
      price: '28',
      providerName: 'Vishnu',
      rating: 4.2,
    ),
    ServiceCard(
      imageUrl: "assets/services/plumbing_service.jpg",
      discount: '15',
      serviceName: 'Plumbing',
      price: '35',
      providerName: 'Abhishek',
      rating: 4.1,
    ),
    ServiceCard(
      imageUrl: "assets/services/painting_service.jpg",
      discount: '25',
      serviceName: 'Painting',
      price: '40',
      providerName: 'Venkat',
      rating: 4.2,
    ),
    ServiceCard(
      imageUrl: "assets/services/repair_service.jpg",
      discount: '20',
      serviceName: 'Repair',
      price: '45',
      providerName: 'prakash',
      rating: 4.6,
    ),
    ServiceCard(
      imageUrl: "assets/services/cleaning_service.jpg",
      discount: '15',
      serviceName: 'Cleaning',
      price: '25',
      providerName: 'Maria',
      rating: 4.4,
    ),
    ServiceCard(
      imageUrl: "assets/services/washing_service.jpg",
      discount: '23',
      serviceName: 'Washing',
      price: '28',
      providerName: 'Vishnu',
      rating: 4.2,
    ),
    ServiceCard(
      imageUrl: "assets/services/plumbing_service.jpg",
      discount: '15',
      serviceName: 'Plumbing',
      price: '35',
      providerName: 'Abhishek',
      rating: 4.1,
    ),
    ServiceCard(
      imageUrl: "assets/services/painting_service.jpg",
      discount: '25',
      serviceName: 'Painting',
      price: '40',
      providerName: 'Venkat',
      rating: 4.2,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: length,
          itemBuilder: (context, index) {
            return serviceCards[index];
          }),
    );
  }
}

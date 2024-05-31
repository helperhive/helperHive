import 'package:flutter/material.dart';
import 'package:helperhive/widgets/book_again_card.dart';

class BookAgainList extends StatelessWidget {
  const BookAgainList({
    super.key,
  });

  final List<BookAgainCard> bookAgainCards = const [
    BookAgainCard(
      imageUrl: "assets/services/repair_service.jpg",
      discount: '20',
      serviceName: 'Repair',
      price: '45',
      providerName: 'prakash',
      rating: 4.6,
    ),
    BookAgainCard(
      imageUrl: "assets/services/cleaning_service.jpg",
      discount: '15',
      serviceName: 'Cleaning',
      price: '25',
      providerName: 'Maria',
      rating: 4.4,
    ),
    BookAgainCard(
      imageUrl: "assets/services/washing_service.jpg",
      discount: '23',
      serviceName: 'Washing',
      price: '28',
      providerName: 'Vishnu',
      rating: 4.2,
    ),
    BookAgainCard(
      imageUrl: "assets/services/plumbing_service.jpg",
      discount: '15',
      serviceName: 'Plumbing',
      price: '35',
      providerName: 'Abhishek',
      rating: 4.1,
    ),
    BookAgainCard(
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
        child: SizedBox(
      height: 130,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          // physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: bookAgainCards.length,
          itemBuilder: (context, index) {
            return bookAgainCards[index];
          }),
    ));
  }
}

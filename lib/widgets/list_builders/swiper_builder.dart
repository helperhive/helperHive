import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:helperhive/widgets/cards/my_booking_card.dart';

class SwiperBuilder extends StatelessWidget {
  SwiperBuilder({super.key});
  final List<MyBookingCard> myBookingCards = [
    MyBookingCard(
        imageUrl: 'assets/services/cleaning_service.jpg',
        time: "10:30 AM",
        serviceName: "House Cleaning",
        price: "38",
        providerName: 'Venkat',
        date: DateTime(2024, 6, 3)),
    MyBookingCard(
        imageUrl: 'assets/services/washing_service.jpg',
        time: "11:30 AM",
        serviceName: "Washing",
        price: "38",
        providerName: 'Narasimha',
        date: DateTime(2024, 6, 4)),
    MyBookingCard(
        imageUrl: 'assets/services/plumbing_service.jpg',
        time: "9:30 AM",
        serviceName: "Plumbing",
        price: "38",
        providerName: 'Vishnnu',
        date: DateTime(2024, 6, 2)),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Flexible(
        child: Align(
      alignment: Alignment.centerLeft,
      child: Swiper(
        itemWidth: width * 0.95,
        itemHeight: 170,
        loop: true,
        itemCount: myBookingCards.length,
        axisDirection: AxisDirection.right,
        duration: 1200,
        scrollDirection: Axis.horizontal,
        layout: SwiperLayout.TINDER,
        viewportFraction: 0.8,
        itemBuilder: (context, index) {
          return myBookingCards[index];
        },
      ),
    ));
  }
}

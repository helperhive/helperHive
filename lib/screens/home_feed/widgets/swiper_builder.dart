import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:helperhive/backend/providers/user_provider.dart';
import 'package:helperhive/constants/color_them.dart';
import 'package:helperhive/enums/issue_type.dart';
import 'package:helperhive/enums/service_enum.dart';
import 'package:helperhive/model/service_booking.dart';
import 'package:helperhive/screens/myBookings/screens/my_booking_screen.dart';
import 'package:helperhive/screens/search/service_search_screen.dart';
import 'package:lottie/lottie.dart';

class SwiperBuilder extends StatelessWidget {
  final UserProvider userProvider;
  const SwiperBuilder({super.key, required this.userProvider});

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
        itemCount:
            userProvider.myBookigs.isEmpty ? 5 : userProvider.myBookigs.length,
        axisDirection: AxisDirection.right,
        duration: 1200,
        scrollDirection: Axis.horizontal,
        layout: SwiperLayout.TINDER,
        viewportFraction: 0.8,
        itemBuilder: (context, index) {
          if (userProvider.myBookigs.isEmpty) {
            return const NoBookingCard();
          }
          return MyBookingCard(serviceBooking: userProvider.myBookigs[index]);
        },
      ),
    ));
  }
}

class NoBookingCard extends StatelessWidget {
  const NoBookingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ServiceSearchScreen()),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Container(
          height: 160,
          // width: 300,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 1),
                    spreadRadius: 2,
                    blurRadius: 2)
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Lottie.asset(
                'assets/not_found/no_booking.json',
                height: 60,
                repeat: true,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'No Current Bookings Found',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'You have no bookings at the moment. Book a service now',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyBookingCard extends StatelessWidget {
  final ServiceBooking serviceBooking;

  const MyBookingCard({
    super.key,
    required this.serviceBooking,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MyBookingScreen(),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Container(
          height: 160,
          // width: 300,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 1),
                    spreadRadius: 2,
                    blurRadius: 2)
              ]),
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: SizedBox(
                    width: 110,
                    height: 150,
                    child: Image.asset(
                      getAssetForService(serviceBooking.service),
                    ),
                  ),
                ),
                const SizedBox(width: 6.0),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0, left: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Service: ${serviceBooking.service.toTitle()}",
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.deepPurpleAccent,
                              fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(height: 4.0),
                        RichText(
                            text: TextSpan(
                                style: const TextStyle(color: primaryColor),
                                children: [
                              const TextSpan(
                                  text: ' By  ',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: serviceBooking.name,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold))
                            ])),

                        const SizedBox(height: 4.0),
                        Text(
                          "Date: ${serviceBooking.bookingDate}",
                          style: const TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          "Time: ${serviceBooking.timeSlot}",
                          style: const TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4.0),

                        // Text('By $providerName'),

                        Text(
                          "Issue Type: ${serviceBooking.issueType ?? IssueType.notKnown}",
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                              color: getIssueColor(serviceBooking.issueType ??
                                  IssueType.notKnown)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

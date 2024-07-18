import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helperhive/backend/providers/my_booking_provider.dart';
import 'package:helperhive/constants/color_them.dart';
import 'package:helperhive/model/service_booking.dart';
import 'package:helperhive/screens/booking/widgets/categorybutton.dart';
import 'package:helperhive/screens/myBookings/lists/booking_screen_list.dart';
import 'package:helperhive/widgets/search_bar_home.dart';
import 'package:provider/provider.dart';

import 'widgets/my_booking_card.dart';

class MyBookingScreen extends StatefulWidget {
  const MyBookingScreen({super.key});

  @override
  MyBookingScreenState createState() => MyBookingScreenState();
}

class MyBookingScreenState extends State<MyBookingScreen> {
  String selectedCategory = 'currnet';
  String searchQuery = '';
  bool isHovering = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User _user = FirebaseAuth.instance.currentUser!;
  void selectCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.menu,
                color: primaryColor,
                size: 32,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_outlined,
                color: primaryColor,
                size: 32,
              ),
            )
          ],
        ),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: SearchBarHome(
              onSearch: updateSearchQuery,
            )),
      ),
      body: Consumer<MyBookingProvider>(builder: (context, provider, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: CategoryButton(
                      choice: 'current',
                      isSelected: selectedCategory == 'current',
                      onPressed: () => selectCategory('current'),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: CategoryButton(
                      choice: 'Previous ',
                      isSelected: selectedCategory == 'Previous ',
                      onPressed: () => selectCategory('Previous '),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              StreamBuilder(
                stream: _firestore
                    .collection('users')
                    .doc(_user.uid)
                    .collection('myBookings')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No bookings found.'));
                  }

                  final bookings = snapshot.data!.docs;

                  return ListView.separated(
                    // padding: EdgeInsets.only(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final booking = bookings[index];
                      // Replace with your booking data fields
                      final bookingData = ServiceBooking.fromSnapshot(booking);

                      return MyBookingCard(serviceBooking: bookingData);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 16,
                      );
                    },
                    itemCount: bookings.length,
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}

class CurrentBookings extends StatelessWidget {
  const CurrentBookings({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helperhive/backend/providers/booking_provider.dart';
// import 'package:helperhive/backend/providers/my_booking_provider.dart';
import 'package:helperhive/constants/color_them.dart';
import 'package:helperhive/model/service_booking.dart';
import 'package:helperhive/screens/booking/widgets/categorybutton.dart';
import 'package:helperhive/screens/search/service_search_screen.dart';
import 'package:helperhive/widgets/search_bar_home.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../widgets/my_booking_card.dart';

class MyBookingScreen extends StatefulWidget {
  const MyBookingScreen({super.key});

  @override
  MyBookingScreenState createState() => MyBookingScreenState();
}

class MyBookingScreenState extends State<MyBookingScreen> {
  String selectedCategory = 'current';
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
    return Consumer<BookingProvider>(builder: (context, provider, _) {
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
        body: SingleChildScrollView(
          child: Padding(
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
                        isSelected: selectedCategory == 'Previous',
                        onPressed: () => selectCategory('Previous'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                if (selectedCategory == 'current')
                  MyBookingStream(firestore: _firestore, user: _user),
                if (selectedCategory == 'Previous')
                  PreviousBookingStream(firestore: _firestore, user: _user),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class MyBookingStream extends StatelessWidget {
  final FirebaseFirestore firestore;
  final User user;

  const MyBookingStream(
      {super.key, required this.firestore, required this.user});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: firestore
          .collection('users')
          .doc(user.uid)
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
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Lottie.asset(
                  'assets/not_found/no_booking.json',
                  height: 160,
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
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to booking screen

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ServiceSearchScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blueColor,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Book a Service Now',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        final bookings = snapshot.data!.docs;

        return ListView.separated(
          // padding: EdgeInsets.only(),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
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
    );
  }
}

class PreviousBookingStream extends StatelessWidget {
  final FirebaseFirestore firestore;
  final User user;

  const PreviousBookingStream(
      {super.key, required this.firestore, required this.user});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: firestore
          .collection('users')
          .doc(user.uid)
          .collection('previousBookings')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Lottie.asset(
                  'assets/not_found/no_booking.json',
                  height: 160,
                  repeat: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'No Previous Bookings Found',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'You have no previous bookings at the moment. Book a service now',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to booking screen

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ServiceSearchScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blueColor,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Book a Service Now',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        final bookings = snapshot.data!.docs;

        return ListView.separated(
          // padding: EdgeInsets.only(),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),

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
    );
  }
}

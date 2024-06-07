import 'package:flutter/material.dart';
import 'package:helperhive/constants/color_them.dart';
import 'package:helperhive/widgets/categorybutton.dart';
import 'package:helperhive/widgets/list_builders/booking_screen_list.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  BookingScreenState createState() => BookingScreenState();
}

class BookingScreenState extends State<BookingScreen> {
  String selectedCategory = 'Bookings';
  String searchQuery = '';
  bool isHovering = false;

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
        title: const Text(
          'Booking Details',
          style: TextStyle(fontSize: Checkbox.width),
        ),
        backgroundColor: blueColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: CategoryButton(
                    choice: 'Bookings',
                    isSelected: selectedCategory == 'Bookings',
                    onPressed: () => selectCategory('Bookings'),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: CategoryButton(
                    choice: 'Previous Bookings',
                    isSelected: selectedCategory == 'Previous Bookings',
                    onPressed: () => selectCategory('Previous Bookings'),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SpecialistList(
                selectedCategory: selectedCategory,
                searchQuery: searchQuery,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

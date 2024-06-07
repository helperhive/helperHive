import 'package:flutter/material.dart';
import 'package:helperhive/constants/color_them.dart';

class BookingScreenCategories extends StatelessWidget {
  final Function(String) onSelectCategory;
  final String selectedCategory;

  const BookingScreenCategories({
    super.key,
    required this.onSelectCategory,
    required this.selectedCategory,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          CategoryButton(
            choice: 'Bookings',
            isSelected: selectedCategory == 'Bookings',
            onPressed: () => onSelectCategory('Bookings'),
          ),
          CategoryButton(
            choice: 'Previous Booking',
            isSelected: selectedCategory == 'Previous Booking',
            onPressed: () => onSelectCategory('Previous Booking'),
          ),
        ],
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String choice;
  final bool isSelected;
  final VoidCallback onPressed;

  const CategoryButton({
    super.key,
    required this.choice,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    String buttonText =
        choice == 'Previous Booking' && isSelected ? 'Booked' : choice;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? blueColor : Colors.grey[200],
          foregroundColor: isSelected ? Colors.white : Colors.black,
        ),
        onPressed: onPressed,
        child: Text(buttonText),
      ),
    );
  }
}

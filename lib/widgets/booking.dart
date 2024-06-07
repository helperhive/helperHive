import 'package:flutter/material.dart';

class BookingHours extends StatelessWidget {
  final String day;
  final String startTime;
  final String endTime;

  const BookingHours({
    super.key, // Corrected parameter name
    required this.day,
    this.startTime = '',
    this.endTime = '',
  }); // Added super constructor call

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(day),
                ],
              ),
            ],
          ),
          startTime.isNotEmpty && endTime.isNotEmpty
              ? Text('$startTime - $endTime')
              : const Text('Closed', style: TextStyle(color: Colors.red)),
        ],
      ),
    );
  }
}

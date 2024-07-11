import 'package:flutter/material.dart';
import 'package:helperhive/constants/color_them.dart';
import 'package:helperhive/screens/payment_screen.dart';

class BookingTimeScreen extends StatefulWidget {
  const BookingTimeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BookingTimeScreenState createState() => _BookingTimeScreenState();
}

class _BookingTimeScreenState extends State<BookingTimeScreen> {
  bool isBooking = false;
  int? selectedDuration;
  double? charges;

  final double hourlyRate = 100.0; // $100 per hour

  final List<int> availableDurations = [1, 2, 3, 4, 5]; // in hours

  Widget _buildDurationButton(int duration) {
    final isSelected = selectedDuration == duration;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      decoration: BoxDecoration(
        color: isSelected ? blueColor : Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextButton(
        onPressed: () => _selectDuration(duration),
        child: Text(
          '$duration hour${duration > 1 ? 's' : ''}',
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  void _selectDuration(int duration) {
    setState(() {
      selectedDuration = duration;
      // Calculate charges
      charges = hourlyRate * duration;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Booking Time Duration',
          style: TextStyle(fontSize: Checkbox.width),
        ),
        backgroundColor: blueColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          AssetImage("assets/services/services_cleaning.png"),
                    ),
                    title: Text(
                      'Vishnu',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Electrician',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.location_on,
                                size: 16, color: Colors.red),
                            SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                'Bhimavaram, Andhra Pradesh',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Select Duration of Time : ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: availableDurations
                        .map((duration) => _buildDurationButton(duration))
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    elevation: 3,
                    color: searchColor,
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (selectedDuration != null)
                            Text(
                              'Selected Time Duration: $selectedDuration hour${selectedDuration! > 1 ? 's' : ''}',
                              style: const TextStyle(fontSize: 17),
                            ),
                          const SizedBox(height: 10),
                          if (charges != null)
                            Text(
                              'Charges: ₹ ${charges!.toStringAsFixed(2)}',
                              style: const TextStyle(fontSize: 17),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 43,
                    child: ElevatedButton(
                      onPressed: isBooking || selectedDuration == null
                          ? null
                          : () async {
                              setState(() {
                                isBooking = true;
                              });
                              await Future.delayed(const Duration(seconds: 1));
                              setState(() {
                                isBooking = false;
                              });
                              Navigator.push(
                                // ignore: use_build_context_synchronously
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PaymentScreen(),
                                ),
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text('Next'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

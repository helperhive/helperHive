import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:helperhive/constants/color_them.dart';
import 'package:helperhive/screens/booking/booking_time_screen.dart';
import 'package:table_calendar/table_calendar.dart';

import 'widgets/calender.dart';

class BookingDateScreen extends StatefulWidget {
  const BookingDateScreen({super.key});

  @override
  BookingDateScreenState createState() => BookingDateScreenState();
}

class BookingDateScreenState extends State<BookingDateScreen> {
  final ScrollController scrollController = ScrollController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  bool isBooking = false;

  // User details
  final String userName = 'Vishnu';
  final String userSpecialty = 'Electrician';
  final String userLocation = 'Bhimavaram, Andhra Pradesh';
  final String userImageUrl = 'assets/naruto.jpeg';

  final List<TimeOfDay> availableTimes = [
    const TimeOfDay(hour: 10, minute: 0),
    const TimeOfDay(hour: 11, minute: 0),
    const TimeOfDay(hour: 12, minute: 0),
    const TimeOfDay(hour: 13, minute: 0),
    const TimeOfDay(hour: 14, minute: 0),
    const TimeOfDay(hour: 15, minute: 0),
    const TimeOfDay(hour: 16, minute: 0),
    const TimeOfDay(hour: 17, minute: 0),
  ];

  void _selectTime(TimeOfDay time) {
    setState(() {
      selectedTime = time;
    });
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      selectedDate = selectedDay;
      selectedTime = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Booking Appointment',
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
                      backgroundImage: AssetImage("assets/naruto.jpeg"),
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
                    'Select Date : ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(height: 17),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: CalendarTabBoking(),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    selectedDate != null
                        ? DateFormat('EEEE, MMMM d, y').format(selectedDate!)
                        : '',
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    'Select Time : ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: availableTimes
                        .map((time) => _buildTimeBox(time))
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  if (selectedTime != null)
                    Text(
                      DateFormat('h:mm a')
                          .format(_convertTimeOfDayToDateTime(selectedTime!)),
                      style: const TextStyle(fontSize: 15),
                    ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 43,
                    child: ElevatedButton(
                      onPressed: isBooking ||
                              (selectedDate == null || selectedTime == null)
                          ? null
                          : () async {
                              setState(() {
                                isBooking = true;
                              });
                              await Future.delayed(const Duration(
                                  seconds: 1)); // Simulate network latency
                              setState(() {
                                isBooking = false;
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const BookingTimeScreen(),
                                ),
                              );
                            },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 50)),
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

  Widget _buildTimeBox(TimeOfDay time) {
    final isSelected = selectedTime == time;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: isSelected ? blueColor : Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextButton(
        onPressed: selectedDate == null ? null : () => _selectTime(time),
        child: Text(
          time.format(context),
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  DateTime _convertTimeOfDayToDateTime(TimeOfDay time) {
    return DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      time.hour,
      time.minute,
    );
  }
}

class DatePickerScreen extends StatelessWidget {
  const DatePickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Date Picker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Select a date:',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(const Duration(days: 365)),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (pickedDate != null) {
                  Navigator.pop(context, pickedDate);
                }
              },
              child: const Text('Select Date'),
            ),
          ],
        ),
      ),
    );
  }
}

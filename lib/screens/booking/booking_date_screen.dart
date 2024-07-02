import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:helperhive/constants/color_them.dart';
import 'package:helperhive/screens/booking/booking_time_screen.dart';

class BookingDateScreen extends StatefulWidget {
  const BookingDateScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BookingDateScreenState createState() => _BookingDateScreenState();
}

class _BookingDateScreenState extends State<BookingDateScreen> {
  final ScrollController scrollController =
      ScrollController(); // Scroll controller for horizontal scrolling
  List<DateTime> displayedDates = []; // List of dates to display
  DateTime? selectedDate; // Currently selected date
  TimeOfDay? selectedTime; // Currently selected time
  bool isBooking = false; // Flag to prevent multiple bookings

  // User details
  final String userName = 'Vishnu';
  final String userSpecialty = 'Electrician';
  final String userLocation = 'Bhimavaram, Andhra Pradesh';
  final String userImageUrl =
      'assets/naruto.jpeg'; // Replace with your image path

  final List<TimeOfDay> availableTimes = [
    const TimeOfDay(hour: 10, minute: 0),
    const TimeOfDay(hour: 11, minute: 0),
    const TimeOfDay(hour: 12, minute: 0),
    const TimeOfDay(hour: 1, minute: 0),
    const TimeOfDay(hour: 2, minute: 0),
    const TimeOfDay(hour: 3, minute: 0),
    const TimeOfDay(hour: 4, minute: 0),
    const TimeOfDay(hour: 5, minute: 0),
  ];

  @override
  void initState() {
    super.initState();
    // Generate initial list of displayed dates (replace with your logic)
    displayedDates =
        List.generate(7, (index) => DateTime.now().add(Duration(days: index)));
  }

  void _selectTime(TimeOfDay time) {
    setState(() {
      selectedTime = time;
    });
  }

  Widget _buildDateBox(DateTime date) {
    final isSelected = selectedDate == date;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
      padding: const EdgeInsets.symmetric(vertical: 23.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: isSelected ? blueColor : Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextButton(
        onPressed: () {
          setState(() {
            selectedDate = date;
            selectedTime = null; // Reset selected time
          });
        },
        child: Text(
          DateFormat('EEE\nMMM d').format(date),
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
          textAlign: TextAlign.center,
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
        padding:
            const EdgeInsets.all(12.0), // Adjust the padding values as needed
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
                  // Booking Calendar with Scrollbar
                  Scrollbar(
                    controller: scrollController,
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      controller: scrollController,
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: displayedDates
                            .map((date) => _buildDateBox(date))
                            .toList(),
                      ),
                    ),
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
                  // Static Time Buttons
                  Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: availableTimes
                        .map((time) => _buildTimeBox(time))
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  // Display selected time (if available)
                  if (selectedTime != null)
                    Text(
                      DateFormat('h:mm a')
                          .format(_convertTimeOfDayToDateTime(selectedTime!)),
                      style: const TextStyle(fontSize: 15),
                    ),
                  const SizedBox(height: 30),
                  // Button to book appointment (enabled only if date and time are selected)
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
                              // Implement your booking logic here
                              await Future.delayed(const Duration(
                                  seconds: 1)); // Simulate network latency
                              setState(() {
                                isBooking = false;
                              });
                              Navigator.push(
                                // ignore: use_build_context_synchronously
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const BookingTimeScreen(),
                                ),
                              );
                              // final bookedDateTime =
                              //     _convertTimeOfDayToDateTime(selectedTime!);
                              // ignore: use_build_context_synchronously
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //     SnackBar(
                              //       content: Text(
                              //           'Appointment Booked for ${DateFormat('EEEE, MMMM d, y - h:mm a').format(bookedDateTime)}'),
                              //       backgroundColor: Colors.green,
                              //     ),
                              //   );
                            },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 50)),
                      child: const Text('Next'),
                    ),
                  ),
                  // const SizedBox(height: 20),
                ],
              ),
            ),
          ),
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
                  // ignore: use_build_context_synchronously
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

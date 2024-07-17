import 'package:flutter/material.dart';
import 'package:helperhive/backend/providers/booking_provider.dart';
import 'package:helperhive/constants/color_them.dart';
import 'package:helperhive/model/service_person.dart';
import 'package:helperhive/screens/booking/widgets/text_filed.dart';
import 'package:provider/provider.dart';

import 'booking_time_screen.dart';
import 'widgets/calender.dart';

class BookingDateScreen extends StatelessWidget {
  final ServicePerson servicePerson;
  BookingDateScreen({super.key, required this.servicePerson});

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController alternateTimeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<BookingProvider>(builder: (context, provider, _) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Booking Screen',
            style: TextStyle(fontSize: Checkbox.width),
          ),
          backgroundColor: blueColor,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(servicePerson.profileUrl),
                  ),
                  title: Text(
                    servicePerson.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        servicePerson.service.toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              size: 16, color: Colors.red),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              servicePerson.location != ''
                                  ? servicePerson.location
                                  : 'Bhimavaram, Andhra Pradesh',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const CalendarTabBoking(
                    // dateSelect: (DateTime? dateTime) {
                    //   selectedDate = dateTime;
                    // },
                    ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    provider.slotTimeSelect(context);
                    // timeController = TextEditingController(text: provider.slotTime);
                  },
                  child: InputTextField(
                      enable: false,
                      leadingIcon: Icons.access_time_outlined,
                      controller: timeController,
                      hintText: 'Slot Time'),
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () => provider.slotAlternateTimeSelect(context),
                  child: InputTextField(
                      enable: false,
                      leadingIcon: Icons.access_time_outlined,
                      controller: alternateTimeController,
                      hintText: 'Alternate Slot Time'),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 42,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BookingTimeScreen(),
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
      );
    });
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

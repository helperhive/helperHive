// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helperhive/backend/providers/user_provider.dart';
import 'package:helperhive/constants/toast.dart';
import 'package:provider/provider.dart';

import 'package:helperhive/backend/providers/booking_provider.dart';
import 'package:helperhive/constants/color_them.dart';
import 'package:helperhive/constants/utils.dart';
import 'package:helperhive/model/service_person.dart';
import 'package:helperhive/screens/booking/widgets/text_filed.dart';

import 'booking_time_screen.dart';
import 'widgets/calender.dart';

class BookingDateScreen extends StatelessWidget {
  final ServicePerson servicePerson;
  BookingDateScreen({
    super.key,
    required this.servicePerson,
  });

  final TextEditingController locationController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
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
                // const SizedBox(height: 10),
                const CalendarTabBoking(
                    // dateSelect: (DateTime? dateTime) {
                    //   selectedDate = dateTime;
                    // },
                    ),
                const SizedBox(height: 10),
                Text(
                  'Booking Time',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade500,
                  ),
                ),
                const SizedBox(height: 5),
                GestureDetector(
                    onTap: provider.setCalenderFormate,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(16)),
                      child: Row(
                        children: [
                          const Icon(Icons.access_time_outlined),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            DateTimeManager.convertDate(provider.selectedDate),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    )),
                const SizedBox(height: 10),
                Text(
                  'Slot Time',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade500,
                  ),
                ),
                const SizedBox(height: 5),
                GestureDetector(
                    onTap: () {
                      provider.slotTimeSelect(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(16)),
                      child: Row(
                        children: [
                          const Icon(Icons.access_time_outlined),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            provider.slotTime.format(context) == '5:00 AM'
                                ? 'Slot Timing'
                                : provider.slotTime.format(context),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    )),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Alternate Slot',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade500,
                  ),
                ),
                const SizedBox(height: 5),
                GestureDetector(
                  onTap: () => provider.slotAlternateTimeSelect(context),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      children: [
                        const Icon(Icons.access_time_outlined),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          provider.alternateSlotTime.format(context) ==
                                  '7:00 AM'
                              ? 'Alternate Slot Timing'
                              : provider.alternateSlotTime.format(context),
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InputTextField(
                  leadingIcon: Icons.location_on,
                  controller: locationController,
                  hintText: userProvider.user.location ?? 'Enter Address',
                  label: 'Address',
                ),
                const SizedBox(
                  height: 10,
                ),
                InputTextField(
                  leadingIcon: Icons.location_on,
                  controller: noteController,
                  hintText: 'Any Requirements',
                  label: 'Note (if any)',
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      await slotBooking(provider, context, userProvider);
                    },
                    child: Container(
                        width: 300,
                        height: 48,
                        decoration: BoxDecoration(
                            color: blueColor,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(2, 6),
                                  color: Colors.grey.shade400,
                                  spreadRadius: 1,
                                  blurRadius: 4)
                            ]),
                        child: Center(
                          child: provider.isBooking
                              ? const CupertinoActivityIndicator(
                                  color: Colors.white,
                                  // radius: 10,
                                )
                              : const Text(
                                  'Complete Booking',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                        )),
                  ),
                ),

                const SizedBox(
                  height: 32,
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<void> slotBooking(BookingProvider provider, BuildContext context,
      UserProvider userProvider) async {
    if (provider.slotTime == const TimeOfDay(hour: 5, minute: 0)) {
      toastMessage(
          context: context,
          message: 'Please Select the slot time',
          position: DelightSnackbarPosition.top);
    }
    String res = await provider.completeBoooking(
      servicePerson: servicePerson,
      user: userProvider.user,
      location: locationController.text.isEmpty
          ? userProvider.user.location!
          : locationController.text.trim(),
      timeSlot: provider.slotTime.format(context),
      bookingDate: DateTimeManager.convertDate(provider.selectedDate),
      alternateTimeSlot: provider.alternateSlotTime.format(context),
      note: noteController.text.trim(),
    );
    if (res == 'success') {
      toastMessage(context: context, message: 'Slot Booking Confirmed');
      noteController.text = '';
    }
  }
}

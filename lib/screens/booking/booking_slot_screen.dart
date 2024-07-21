// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helperhive/backend/providers/user_provider.dart';
import 'package:helperhive/constants/toast.dart';
import 'package:helperhive/enums/issue_type.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'package:helperhive/backend/providers/booking_provider.dart';
import 'package:helperhive/constants/color_them.dart';
import 'package:helperhive/constants/utils.dart';
import 'package:helperhive/model/service_person.dart';
import 'package:helperhive/screens/booking/widgets/text_filed.dart';

import 'widgets/calender.dart';

class BookingSlotScreen extends StatelessWidget {
  final ServicePerson servicePerson;
  BookingSlotScreen({
    super.key,
    required this.servicePerson,
  });
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Consumer<BookingProvider>(builder: (context, provider, _) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text(
            'Booking Screen',
            style: TextStyle(color: Colors.white, fontSize: Checkbox.width),
          ),
          backgroundColor: blueColor,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context)
                    .viewInsets
                    .bottom), // Adjust bottom padding to avoid keyboard
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior
                .onDrag, // Dismiss keyboard on scroll
            physics: const BouncingScrollPhysics(), // Add scroll physics

            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2101));

                                if (pickedDate != null) {
                                  provider.isSelectedDateOk(
                                      pickedDate, pickedDate);
                                  if (!provider.isSelected) {
                                    toastMessage(
                                        context: context,
                                        message: 'Please select a valid date',
                                        position: DelightSnackbarPosition.top,
                                        messageColor: Colors.red,
                                        leadingIcon: const Icon(
                                          Icons.cancel,
                                          color: Colors.red,
                                        ));
                                  }
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                width: 162,
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
                                      DateTimeManager.convertDate(
                                          provider.selectedDate),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Issue Type',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          const SizedBox(height: 5),
                          GestureDetector(
                              // onTap: provider.setCalenderFormate,
                              child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            width: 162,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(16)),
                            child: DropdownButton<IssueType>(
                                // padding: const EdgeInsets.all(0),
                                hint: const Row(
                                  children: [
                                    Icon(Icons
                                        .error_outline), // Placeholder icon
                                    SizedBox(width: 8),
                                    Text(
                                      "Select Issue",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                value: provider.issueType,
                                items: IssueType.values.map((IssueType issue) {
                                  return DropdownMenuItem<IssueType>(
                                    value: issue,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          getIssueIcon(issue),
                                          color: getIssueColor(issue),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          issue.toString(),
                                          style: TextStyle(
                                              color: getIssueColor(issue)),
                                        ),
                                      ],
                                    ),
                                    // child: Text(
                                    //   issue.toString(),
                                    //   style:
                                    //       TextStyle(color: getIssueColor(issue)),
                                    // ),
                                  );
                                }).toList(),
                                onChanged: provider.selectIssue),
                          )),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Time Slot',
                            style: TextStyle(
                              height: 1,
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
                              width: 162,
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
                                    provider.slotTime.format(context) ==
                                            '5:00 AM'
                                        ? 'Slot Timing'
                                        : provider.slotTime.format(context),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (provider.slotTime ==
                              const TimeOfDay(hour: 5, minute: 0))
                            const Text(
                              'Slot is required',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.red),
                            ),
                        ],
                      ),
                      // const SizedBox(
                      //   width: 5,
                      // ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                              text: 'Alternate Slot ',
                              style: TextStyle(
                                height: 1.1,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade500.withOpacity(0.8),
                              ),
                            ),
                            TextSpan(
                              text: '(if need)',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade500.withOpacity(0.8),
                              ),
                            )
                          ])),
                          const SizedBox(height: 5),
                          GestureDetector(
                            onTap: () =>
                                provider.slotAlternateTimeSelect(context),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              width: 162,
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
                                    provider.alternateSlotTime
                                                .format(context) ==
                                            '12:00 AM'
                                        ? 'Alternate Slot'
                                        : provider.alternateSlotTime
                                            .format(context),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (provider.slotTime ==
                              const TimeOfDay(hour: 5, minute: 0))
                            const SizedBox(
                              height: 20,
                            )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InputTextField(
                    leadingIcon: Icons.phone,
                    controller: phoneNumberController,
                    hintText: userProvider.user.phoneNumber,
                    label: 'Contact Number',
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
                    height: 16,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        await slotBooking(provider, context, userProvider);

                        // showCustomBookingConfirmedDialog(context);
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
                                    radius: 10,
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
        ),
      );
    });
  }

  Future<void> slotBooking(BookingProvider provider, BuildContext context,
      UserProvider userProvider) async {
    if (provider.slotTime == const TimeOfDay(hour: 5, minute: 0)) {
      // toastMessage(
      //     context: context,
      //     message: 'Please Select the slot time',
      //     position: DelightSnackbarPosition.top); //TODO toast functionality
      // await Future.delayed(Duration.zero);
      return;
    }

    String res = await provider.completeBoooking(
      servicePerson: servicePerson,
      user: userProvider.user,
      phoneNumber: phoneNumberController.text.isEmpty
          ? userProvider.user.phoneNumber
          : phoneNumberController.text.trim(),
      location: locationController.text.isEmpty
          ? userProvider.user.location!
          : locationController.text.trim(),
      timeSlot: provider.slotTime.format(context),
      bookingDate: DateTimeManager.convertDate(provider.selectedDate),
      alternateTimeSlot: provider.alternateSlotTime.format(context),
      note: noteController.text.trim(),
    );
    if (res == 'success') {
      // toastMessage(context: context, message: 'Slot Booking Confirmed');
      showCustomBookingConfirmedDialog(context);
      noteController.clear();
    } else {
      toastMessage(context: context, message: res.toString());
    }
  }

  void showCustomBookingConfirmedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetAnimationCurve: Curves.easeInOut,
          insetAnimationDuration: const Duration(milliseconds: 400),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Lottie.asset(
                  repeat: false,
                  'assets/success/booking_success.json',
                  height: 160,
                ),

                // const SizedBox(height: 16.0),
                const Text(
                  'Booking Confirmed',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Your booking has been successfully confirmed. Thank you for booking with us!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blueColor,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

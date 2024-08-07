import 'package:flutter/material.dart';
import 'package:helperhive/backend/providers/message_provider.dart';
import 'package:helperhive/constants/color_them.dart';
import 'package:helperhive/enums/issue_type.dart';
import 'package:helperhive/model/service_booking.dart';
import 'package:helperhive/screens/chats/screens/messages_view.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class MyBookingDetails extends StatelessWidget {
  final Function(bool)? onBack;
  final String senderId;
  final ServiceBooking booking;

  const MyBookingDetails(
      {super.key, this.onBack, required this.booking, required this.senderId});

  @override
  Widget build(BuildContext context) {
    return Consumer<MessageProvider>(builder: (context, provider, _) {
      return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              if (onBack != null) {
                onBack!(false);
              }
              // Go back to the previous screen
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: const Text(
            'Booking Details',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          backgroundColor: blueColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ]),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Service Person: ${booking.name}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.phone, color: Colors.blue),
                          const SizedBox(width: 5),
                          Text(
                            booking.phoneNumber,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const Divider(
                        height: 25,
                      ),
                      const Text(
                        'Booking Details',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      detailRow('Service', booking.service.toString()),
                      detailRow('Booking Date', booking.bookingDate),
                      detailRow('Location', booking.location),
                      detailRow('Time Slot', booking.timeSlot),
                      booking.issueType != null
                          ? detailRow(
                              'Issue Type', booking.issueType.toString(),
                              dataColor: getIssueColor(booking.issueType!))
                          : Container(),
                      booking.alternateTimeSlot != null &&
                              booking.alternateTimeSlot!.isNotEmpty
                          ? detailRow(
                              'Alternate Time Slot', booking.alternateTimeSlot!)
                          : Container(),
                      booking.note != null && booking.note!.isNotEmpty
                          ? detailRow('Note', booking.note!)
                          : Container(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12),
          child: ElevatedButton.icon(
            onPressed: () {
              // Implement payment functionality
            },
            icon: const Icon(
              Icons.payment,
              size: 24,
            ),
            label: const Text(
              'Make Payment',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(8)),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          onPressed: () async {
            await provider.checkChat(
                senderId: senderId, receiverId: booking.uid);
            Navigator.of(context).push(
              PageTransition(
                type: PageTransitionType.bottomToTop,
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 350),
                child: MessagesView(
                  uid: booking.uid,
                ),
              ),
            );
          },
          child: const Icon(
            Icons.chat,
            size: 30,
          ),
        ),
      );
    });
  }

  Widget detailRow(String label, String value, {Color? dataColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          const Icon(Icons.arrow_right, color: Colors.blue),
          const SizedBox(width: 10),
          Text(
            '$label: ',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: dataColor ?? Colors.black, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

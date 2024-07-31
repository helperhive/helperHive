import 'package:flutter/material.dart';
import 'package:helperhive/enums/issue_type.dart';
import 'package:helperhive/enums/service_enum.dart';
import 'package:helperhive/model/service_booking.dart';
import 'package:helperhive/screens/myBookings/screens/my_booking_details.dart';
// import 'package:helperhive/model/service_person.dart';

class MyBookingCard extends StatelessWidget {
  final String currentUserID;
  final ServiceBooking serviceBooking;
  final Function(bool)? navigate;
  const MyBookingCard(
      {super.key,
      this.navigate,
      required this.serviceBooking,
      required this.currentUserID});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigate?.call(true); // Call navigate with true when card is tapped
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MyBookingDetails(
            booking: serviceBooking,
            senderId: currentUserID,
            onBack: (p0) {
              navigate?.call(p0); // Handle the onBack callback
            },
          ),
        ));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 1),
              spreadRadius: 2,
              blurRadius: 2,
            )
          ],
        ),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 65,
              height: 50,
              child: Image.asset(
                getAssetForService(serviceBooking.service),
              ),
            ),
            const SizedBox(width: 6.0),
            Expanded(
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Service: ${serviceBooking.service.toString()}",
                            style: const TextStyle(
                              fontSize: 16,
                              // color: Colors.deepPurpleAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            "Name: ${serviceBooking.name}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: const TextStyle(
                              fontSize: 15.0,
                              // color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            "Issue Type: ${serviceBooking.issueType ?? IssueType.notKnown}",
                            style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                color: getIssueColor(serviceBooking.issueType ??
                                    IssueType.notKnown)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // const SizedBox(
                  //   width: 20,
                  // ),
                  Container(
                    width: 100,
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Date:\n  ${serviceBooking.bookingDate}",
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.deepPurpleAccent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2.0),
                        Text(
                          "Time:\n  ${serviceBooking.timeSlot}",
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.deepPurpleAccent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

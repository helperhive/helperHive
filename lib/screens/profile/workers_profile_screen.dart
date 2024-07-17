import 'package:flutter/material.dart';
import 'package:helperhive/constants/color_them.dart';
import 'package:helperhive/model/service_person.dart';
import 'package:helperhive/screens/booking/booking_date_screen.dart';
import 'package:helperhive/screens/profile/widgets/cards/likecard.dart';
import 'package:helperhive/screens/profile/widgets/cards/reviewcard.dart';
import 'package:helperhive/screens/profile/widgets/show_more_text.dart';

class WorkersProfileScreen extends StatelessWidget {
  final ServicePerson servicePerson;
  const WorkersProfileScreen({super.key, required this.servicePerson});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Service Provider Profile',
            // style: TextStyle(fontWeight: FontWeight.w500),
          ),
          backgroundColor: blueColor,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.favorite,
                // color:
                size: 32,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                                radius: 40,
                                backgroundImage:
                                    NetworkImage(servicePerson.profileUrl)),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.person,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  servicePerson.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.miscellaneous_services,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  servicePerson.service.toString(),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.phone,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  servicePerson.phoneNumber,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.location_on,
                                    size: 20, color: Colors.red),
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Container(
                                width: 150,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 0.5),
                                  borderRadius: BorderRadius.circular(6),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        offset: const Offset(0, 1),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        color: Colors.grey.shade300)
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Icon(Icons.star,
                                        color: Colors.orange, size: 18),
                                    const SizedBox(width: 2.0),
                                    Text(
                                      '${servicePerson.rating} |',
                                      style:
                                          const TextStyle(color: primaryColor),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Icon(
                                      Icons.work_outline,
                                      size: 16,
                                      color: Colors.orange,
                                    ),
                                    const SizedBox(width: 4.0),
                                    Text(
                                      '${servicePerson.experience} Years',
                                      style:
                                          const TextStyle(color: primaryColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'About',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 6),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ShowMoreText(
                    text:
                        'Vishnu, an electrician, is a skilled professional trained in installing, repairing, and maintaining electrical systems. He ensures safety and efficiency in residential, commercial, and industrial settings. With expertise in wiring, troubleshooting, and adherence to safety standards, Vishnu provides essential services while prioritizing customer satisfaction and continuous learning in the ever-evolving field of electrical work.',
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const LikeCard(
                        icon: Icons.person, value: '1000', label: 'Services'),
                    LikeCard(
                        icon: Icons.star,
                        value: servicePerson.rating.toString(),
                        label: 'Ratings'),
                    const LikeCard(
                        icon: Icons.favorite, value: '4.5', label: 'Favorites'),
                    const LikeCard(
                        icon: Icons.thumb_up, value: '4.5', label: 'Likes'),
                  ],
                ),
                const SizedBox(height: 16),
                servicePerson.workingHours != {}
                    ? const SizedBox()
                    : Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Working Hours',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            SizedBox(height: 12),
                            BookingHours(
                              day: 'Sunday',
                              startTime: '',
                              endTime: '',
                            ),
                            BookingHours(
                              day: 'Monday',
                              startTime: '09:00 AM',
                              endTime: '05:00 PM',
                            ),
                            BookingHours(
                              day: 'Tuesday',
                              startTime: '09:00 AM',
                              endTime: '05:00 PM',
                            ),
                            BookingHours(
                              day: 'Wednesday',
                              startTime: '09:00 AM',
                              endTime: '05:00 PM',
                            ),
                            BookingHours(
                              day: 'Thursday',
                              startTime: '09:00 AM',
                              endTime: '05:00 PM',
                            ),
                            BookingHours(
                              day: 'Friday',
                              startTime: '09:00 AM',
                              endTime: '05:00 PM',
                            ),
                            BookingHours(
                              day: 'Saturday',
                              startTime: '09:00 AM',
                              endTime: '05:00 PM',
                            ),
                          ],
                        ),
                      ),
                const SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  height: 43,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingDateScreen(
                            servicePerson: servicePerson,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: blueColor,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50)),
                    child: const Text('Book Appointment'),
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Reviews',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                ReviewCard(
                  review: Review(
                    reviewerName: 'Excellent Work!',
                    rating: 4.5,
                    comment: 'Great service, highly recommended!',
                  ),
                ),
                ReviewCard(
                  review: Review(
                    reviewerName: 'Good !',
                    rating: 4.0,
                    comment: 'Very professional and punctual.',
                  ),
                ),
                ReviewCard(
                  review: Review(
                    reviewerName: 'Excellent Work!',
                    rating: 4.5,
                    comment: 'Great service, highly recommended!',
                  ),
                ),
                ReviewCard(
                  review: Review(
                    reviewerName: 'Satisfactory!',
                    rating: 4.5,
                    comment:
                        'Nice service, Low budget and friendly conversation!',
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class BookingHours extends StatelessWidget {
  final String day;
  final String startTime;
  final String endTime;

  const BookingHours({
    super.key,
    required this.day,
    required this.startTime,
    required this.endTime,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(day),
        Text(startTime == '' ? 'Closed' : '$startTime - $endTime'),
      ],
    );
  }
}

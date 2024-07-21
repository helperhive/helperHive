import 'package:flutter/material.dart';
import 'package:helperhive/constants/color_them.dart';
import 'package:helperhive/model/service_person.dart';
import 'package:helperhive/screens/booking/booking_slot_screen.dart';
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
        title: Row(
          children: [
            CircleAvatar(
              // radius: 16,
              backgroundImage: NetworkImage(servicePerson.profileUrl),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              servicePerson.name,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ],
        ),
        backgroundColor: blueColor,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.favorite,
              size: 32,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 45,
                        backgroundImage: NetworkImage(servicePerson.profileUrl),
                      ),
                      const SizedBox(height: 16),
                      ProfileDetailTable(
                        details: {
                          'Name': servicePerson.name,
                          'Service': servicePerson.service.toString(),
                          'Contact number': servicePerson.phoneNumber,
                          'Location': servicePerson.location.isNotEmpty
                              ? servicePerson.location
                              : 'Bhimavaram, Andhra Pradesh',
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'About',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 6),
              Container(
                color: Colors
                    .blue.shade50, // Background color for the About section
                padding: const EdgeInsets.all(16.0),
                child: ShowMoreText(
                  text:
                      '${servicePerson.name}, an ${servicePerson.service.toString()}, is a skilled professional trained in installing, repairing, and maintaining electrical systems. He ensures safety and efficiency in residential, commercial, and industrial settings. With expertise in wiring, troubleshooting, and adherence to safety standards, Vishnu provides essential services while prioritizing customer satisfaction and continuous learning in the ever-evolving field of electrical work.',
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const LikeCard(
                      icon: Icons.person, value: '1000', label: 'Services'),
                  LikeCard(
                      icon: Icons.work,
                      value: servicePerson.experience.toDouble().toString(),
                      label: 'Experience'),
                  LikeCard(
                      icon: Icons.star,
                      value: servicePerson.rating.toString(),
                      label: 'Ratings'),
                  const LikeCard(
                      icon: Icons.thumb_up, value: '4.5', label: 'Likes'),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 43,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingSlotScreen(
                          servicePerson: servicePerson,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blueColor,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'Book Service',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              servicePerson.workingHours.isNotEmpty
                  ? Container(
                      color: Colors.blue
                          .shade50, // Background color for the Working Hours section
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Working Hours',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 12),
                          ...servicePerson.workingHours.entries.map((entry) {
                            return BookingHours(
                              day: entry.key,
                              startTime: entry.value['startTime'] ?? '',
                              endTime: entry.value['endTime'] ?? '',
                            );
                          }),
                        ],
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(height: 15),
              const Text(
                'Reviews',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Column(
                children: [
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
                          'Nice service, low budget, and friendly conversation!',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileDetailTable extends StatelessWidget {
  final Map<String, String> details;

  const ProfileDetailTable({
    super.key,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: details.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 130,
                child: Text(
                  entry.key,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const Text(
                ': ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Expanded(
                child: Text(
                  entry.value,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150, // Fixed width for days
            child: Text(
              day,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            child: Text(
              startTime.isEmpty ? 'Closed' : '$startTime - $endTime',
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}

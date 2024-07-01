import 'package:flutter/material.dart';
import 'package:helperhive/constants/color_them.dart';
import 'package:helperhive/screens/booking/booking_date_screen.dart';
import 'package:helperhive/screens/profile/widgets/cards/likecard.dart';
import 'package:helperhive/screens/profile/widgets/cards/reviewcard.dart';
import 'package:helperhive/screens/profile/widgets/show_more_text.dart';

class WorkersProfileScreen extends StatefulWidget {
  const WorkersProfileScreen({super.key});

  @override
  State<WorkersProfileScreen> createState() => _WorkersProfileScreenState();
}

class _WorkersProfileScreenState extends State<WorkersProfileScreen> {
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Workers Profile Screen',
            style: TextStyle(fontSize: Checkbox.width),
          ),
          backgroundColor: blueColor,
          actions: [
            IconButton(
              icon: Icon(
                isFavorited ? Icons.favorite : Icons.favorite_border,
                color: isFavorited ? Colors.red : null,
              ),
              onPressed: () {
                setState(() {
                  isFavorited = !isFavorited;
                });
              },
            ),
          ],
        ),
        body: Padding(
          padding:
              const EdgeInsets.all(8.0), // Adjust the padding values as needed
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(6.0),
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                          Icon(Icons.location_on, size: 16, color: Colors.red),
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
                  'About',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 6),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ShowMoreText(
                      text:
                          'Vishnu, an electrician, is a skilled professional trained in installing, repairing, and maintaining electrical systems. He ensures safety and efficiency in residential, commercial, and industrial settings. With expertise in wiring, troubleshooting, and adherence to safety standards, Vishnu provides essential services while prioritizing customer satisfaction and continuous learning in the ever-evolving field of electrical work.'),
                ),
                const SizedBox(height: 16),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LikeCard(
                        icon: Icons.person, value: '1000', label: 'Services'),
                    LikeCard(icon: Icons.star, value: '4.5', label: 'Ratings'),
                    LikeCard(
                        icon: Icons.favorite, value: '4.5', label: 'Favorites'),
                    LikeCard(
                        icon: Icons.thumb_up, value: '4.5', label: 'Likes'),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
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
                          builder: (context) => const BookingDateScreen(),
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

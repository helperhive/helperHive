import 'package:flutter/material.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Person Details'),
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () {
        //     // Handle back button press
        //   },
        // ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50.0,
              backgroundImage: NetworkImage(
                  'https://via.placeholder.com/150'), // Placeholder image
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Dr. Jane Smith',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Cardiology',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8.0),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on, color: Colors.red),
                SizedBox(width: 4.0),
                Text('New York, USA'),
              ],
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Dr. Jane Smith is a cardiologist in New York, New York and is affiliated with multiple hospitals in the area, including Lenox Hill Hospital and NYU Langone.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8.0),
            TextButton(
              onPressed: () {
                // Handle show all button press
              },
              child: const Text('Show All'),
            ),
            const SizedBox(height: 16.0),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(Icons.people, size: 30.0),
                    SizedBox(height: 4.0),
                    Text('1000'),
                    Text('Patients'),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.star, size: 30.0),
                    SizedBox(height: 4.0),
                    Text('4.5'),
                    Text('Ratings'),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.favorite, size: 30.0),
                    SizedBox(height: 4.0),
                    Text('4.5'),
                    Text('Ratings'),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.favorite, size: 30.0),
                    SizedBox(height: 4.0),
                    Text('4.5'),
                    Text('Ratings'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const Divider(),
            const SizedBox(height: 16.0),
            const Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Monday'),
                    Text('09:00 AM - 05:00 PM'),
                  ],
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tuesday'),
                    Text('09:00 AM - 05:00 PM'),
                  ],
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Wednesday'),
                    Text('09:00 AM - 05:00 PM'),
                  ],
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Thursday'),
                    Text('09:00 AM - 05:00 PM'),
                  ],
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Friday'),
                    Text('09:00 AM - 05:00 PM'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Handle book appointment button press
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 50.0, vertical: 15.0),
              ),
              child: const Text('Book Appointment'),
            ),
          ],
        ),
      ),
    );
  }
}

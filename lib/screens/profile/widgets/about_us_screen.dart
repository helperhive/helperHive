import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to our app! We are thrilled to have you here. Our goal is to offer exceptional services and create valuable experiences for our users. Below you can find more about our mission, vision, and values.',
            ),
            const SizedBox(height: 24),
            Text(
              'Our mission is to deliver high-quality, innovative solutions that improve the lives of our users. We are committed to excellence and constantly strive to meet and exceed your expectations.',
            ),
            const SizedBox(height: 24),
            Text(
              'We envision becoming a leading provider of top-notch solutions and making a positive impact on the community. Our vision is to be recognized for our innovation, quality, and customer-centric approach.',
            ),
            const SizedBox(height: 24),
            Text(
              'Integrity, innovation, and customer satisfaction are the core values driving our company. We uphold the highest standards of honesty and transparency, while continuously seeking new ways to enhance our offerings and serve you better.',
            ),
            const SizedBox(height: 24),
            Text(
              'If you have any questions or feedback, please feel free to reach out to us. We value your input and are always here to assist you.',
            ),
            const SizedBox(height: 16),
            Text(
              'Email: support@ourapp.com\nPhone: +1-234-567-8901',
            ),
          ],
        ),
      ),
    );
  }
}

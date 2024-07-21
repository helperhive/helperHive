import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Help',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildHelpMenuItem(
            context,
            text: 'About Us',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutUsScreen(),
                ),
              );
            },
          ),
          _buildHelpMenuItem(
            context,
            text: 'Contact Support',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ContactSupportScreen(),
                ),
              );
            },
          ),
          _buildHelpMenuItem(
            context,
            text: 'FAQs',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FAQScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHelpMenuItem(BuildContext context,
      {required String text, required VoidCallback onTap}) {
    return ListTile(
      title: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      onTap: onTap,
    );
  }
}

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About Us',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to HelperHive! We are thrilled to have you here. Our goal is to offer exceptional services and create valuable experiences for our users. Below you can find more about our mission, vision, and values.',
            ),
            SizedBox(height: 24),
            Text(
              'Our mission at HelperHive is to deliver high-quality, innovative solutions that improve the lives of our users. We are committed to excellence and constantly strive to meet and exceed your expectations.',
            ),
            SizedBox(height: 24),
            Text(
              'We envision HelperHive becoming a leading provider of top-notch solutions and making a positive impact on the community. Our vision is to be recognized for our innovation, quality, and customer-centric approach.',
            ),
            SizedBox(height: 24),
            Text(
              'Integrity, innovation, and customer satisfaction are the core values driving HelperHive. We uphold the highest standards of honesty and transparency, while continuously seeking new ways to enhance our offerings and serve you better.',
            ),
            SizedBox(height: 24),
            Text(
              'If you have any questions or feedback, please feel free to reach out to us. We value your input and are always here to assist you.',
            ),
            SizedBox(height: 16),
            Text(
              'Email: support@helperHive.com\nPhone: +1-234-567-8901',
            ),
          ],
        ),
      ),
    );
  }
}

class ContactSupportScreen extends StatelessWidget {
  const ContactSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contact Support',
          style: TextStyle(
            fontSize: 18,
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'For support, you can reach us through the following methods:',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.email, color: Colors.blue),
              title: const Text('Email'),
              subtitle: const Text('support@example.com'),
              onTap: () {
                // Action for email (e.g., open email client)
              },
            ),
            ListTile(
              leading: const Icon(Icons.phone, color: Colors.blue),
              title: const Text('Phone'),
              subtitle: const Text('+1 234 567 890'),
              onTap: () {
                // Action for phone (e.g., make a call)
              },
            ),
            ListTile(
              leading: const Icon(Icons.chat, color: Colors.blue),
              title: const Text('Live Chat'),
              subtitle: const Text('Chat with us online'),
              onTap: () {
                // Action for live chat (e.g., open chat support)
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FAQs',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildFAQItem(
            context,
            question: 'What is this app about?',
            answer:
                'This app helps users manage their profiles, settings, and support requests.',
          ),
          _buildFAQItem(
            context,
            question: 'How do I reset my password?',
            answer:
                'Go to the settings screen and select "Change Password" to set a new password.',
          ),
          _buildFAQItem(
            context,
            question: 'How can I contact support?',
            answer:
                'Use the "Contact Support" option in the Help section to get in touch with support.',
          ),
          // Add more FAQs as needed
        ],
      ),
    );
  }

  Widget _buildFAQItem(BuildContext context,
      {required String question, required String answer}) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            answer,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}

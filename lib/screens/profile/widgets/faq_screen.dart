import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQs'),
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
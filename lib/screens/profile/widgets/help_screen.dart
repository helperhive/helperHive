import 'package:flutter/material.dart';
import 'package:helperhive/screens/profile/widgets/about_us_screen.dart';
import 'package:helperhive/screens/profile/widgets/contact_support_screen.dart';
import 'package:helperhive/screens/profile/widgets/faq_screen.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
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
      title: Text(text),
      onTap: onTap,
    );
  }
}
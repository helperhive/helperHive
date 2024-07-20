import 'package:flutter/material.dart';
import 'package:helperhive/screens/profile/widgets/account_settings_screen.dart';
import 'package:helperhive/screens/profile/widgets/privacy_settings_screen.dart';
import 'package:helperhive/screens/profile/widgets/security_settings_screen.dart';

import 'profile_menu_item.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool emailNotifications = true;
  bool pushNotifications = true;
  bool smsNotifications = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, // Set the background color to blue
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.white, // Ensure the text color is visible against the blue background
            fontSize: 20, // Adjust font size if needed
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ProfileMenuItem(
            icon: Icons.account_circle,
            text: 'Account Settings',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AccountSettingsScreen(),
                ),
              );
            },
          ),
          ProfileMenuItem(
            icon: Icons.security,
            text: 'Security Settings',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SecuritySettingsScreen(),
                ),
              );
            },
          ),
          ExpansionTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notification Settings'),
            children: [
              SwitchListTile(
                title: const Text('Email Notifications'),
                value: emailNotifications,
                onChanged: (bool value) {
                  setState(() {
                    emailNotifications = value;
                  });
                },
                secondary: const Icon(Icons.email),
              ),
              SwitchListTile(
                title: const Text('Push Notifications'),
                value: pushNotifications,
                onChanged: (bool value) {
                  setState(() {
                    pushNotifications = value;
                  });
                },
                secondary: const Icon(Icons.notifications),
              ),
              SwitchListTile(
                title: const Text('SMS Notifications'),
                value: smsNotifications,
                onChanged: (bool value) {
                  setState(() {
                    smsNotifications = value;
                  });
                },
                secondary: const Icon(Icons.sms),
              ),
            ],
          ),
          ProfileMenuItem(
            icon: Icons.privacy_tip,
            text: 'Privacy Settings',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PrivacySettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

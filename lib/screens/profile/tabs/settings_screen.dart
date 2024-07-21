import 'package:flutter/material.dart';

import '../widgets/profile_menu_item.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool emailNotifications = true;
  bool pushNotifications = true;
  bool smsNotifications = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
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
          const SizedBox(
            height: 10,
          ),
          ExpansionTile(
            collapsedBackgroundColor: Colors.grey[200],
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
        ],
      ),
    );
  }
}

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Settings'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Add your account settings update action here
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Update Account Settings',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PrivacySettingsScreen extends StatelessWidget {
  const PrivacySettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Settings'),
      ),
      body: const Center(
        child: Text(
          'Privacy Settings',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class SecuritySettingsScreen extends StatelessWidget {
  const SecuritySettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Security Settings'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text('Change Password'),
              onTap: () {
                // Navigate to Change Password screen
              },
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.fingerprint),
              title: const Text('Enable Fingerprint'),
              onTap: () {
                // Navigate to Enable Fingerprint screen
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Add your security settings update action here
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Save Changes',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

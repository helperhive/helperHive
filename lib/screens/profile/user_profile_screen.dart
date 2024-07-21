import 'package:flutter/material.dart';
import 'package:helperhive/backend/providers/user_provider.dart';
import 'package:helperhive/enums/service_enum.dart';

import 'package:helperhive/screens/profile/edit_profile_screen.dart';
import 'package:helperhive/screens/profile/tabs/change_password_screen.dart';
import 'package:helperhive/screens/profile/tabs/help_screen.dart';
import 'package:helperhive/screens/profile/tabs/notifications_screen.dart';
import 'package:helperhive/screens/profile/tabs/settings_screen.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatelessWidget {
  final Function()? onTap;
  const UserProfileScreen({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, provider, _) {
      return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.6),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                color: Colors.white.withOpacity(0.6),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        provider.user.profileUrl == ''
                            ? const CircleAvatar(
                                radius: 60,
                                backgroundImage:
                                    AssetImage('assets/profile/profile.png'),
                                backgroundColor: Colors.blueAccent,
                              )
                            : CircleAvatar(
                                radius: 60,
                                backgroundImage:
                                    NetworkImage(provider.user.profileUrl),
                                backgroundColor: Colors.blueAccent,
                              ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const EditProfileScreen(
                                            // userProvider: provider,
                                            ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.edit),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      provider.user.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      provider.user.service == Service.user
                          ? provider.user.phoneNumber
                          : provider.user.service.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  children: [
                    ProfileMenuItem(
                      icon: Icons.person,
                      text: 'Edit Profile',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditProfileScreen(
                                // userProvider: provider,
                                ),
                          ),
                        );
                      },
                    ),
                    ProfileMenuItem(
                      icon: Icons.lock,
                      text: 'Change Password',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChangePasswordScreen(),
                          ),
                        );
                      },
                    ),
                    ProfileMenuItem(
                      icon: Icons.settings,
                      text: 'Settings',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SettingsScreen(),
                          ),
                        );
                      },
                    ),
                    ProfileMenuItem(
                      icon: Icons.notifications,
                      text: 'Notifications',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NotificationsScreen(),
                          ),
                        );
                      },
                    ),
                    ProfileMenuItem(
                      icon: Icons.help,
                      text: 'Help',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HelpScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    ProfileMenuItem(
                      icon: Icons.logout,
                      text: 'Logout',
                      onTap: () => _showLogoutDialog(context),
                      textColor: Colors.red, // Highlight Logout item
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Are you sure you want to logout?',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue),
                        onPressed: onTap,
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final Color? textColor;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 6,
              spreadRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.blueAccent),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: textColor ?? Colors.black,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios,
                color: Colors.blueAccent, size: 16),
          ],
        ),
      ),
    );
  }
}

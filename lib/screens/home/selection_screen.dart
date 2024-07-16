import "package:flutter/material.dart";
import 'package:helperhive/screens/auth/screens/signup.dart';
import 'package:lottie/lottie.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Lottie.asset('assets/onboarding/Animation - selection.json'),
              const SizedBox(
                height: 15,
              ),
              const Text('Who Are You?', style: TextStyle(fontSize: 24)),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: 160,
                  height: 120,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const SignupScreen(
                                      isUser: true,
                                    )));
                          },
                          child: Column(children: [
                            CircleAvatar(
                                radius: 32,
                                child: Image.asset(
                                    'assets/onboarding/person.png')),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'User',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.blue),
                            ),
                          ]),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const SignupScreen(
                                      isUser: false,
                                    )));
                          },
                          child: Column(children: [
                            CircleAvatar(
                                radius: 32,
                                child: Image.asset(
                                    'assets/onboarding/workers.jpg')),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'Service',
                              // maxLines: 2,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.blue),
                            ),
                            const Text(
                              ' Provider',
                              // maxLines: 2,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.blue),
                            ),
                          ]),
                        ),
                      ]))
            ],
          ),
        ),
      ),
    );
  }
}

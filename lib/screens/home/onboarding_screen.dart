import 'package:flutter/material.dart';
import 'package:helperhive/constants/color_them.dart';
import 'package:helperhive/screens/home/home_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreens extends StatefulWidget {
  const OnboardingScreens({super.key});

  @override
  State<OnboardingScreens> createState() => _OnboardingScreensState();
}

class _OnboardingScreensState extends State<OnboardingScreens> {
  final PageController _pageController = PageController();
  bool onlastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (value) {
              setState(() {
                onlastPage = (value == 3);
              });
            },
            children: <Widget>[
              OnboardingScreen(
                title: 'Welcome To HelperHive!..',
                imagePath: 'assets/onboarding/helperHiveLogo.png',
                buttontext: 'Next',
                description:
                    'Instant Access to Top Services.Effortless Connections, Anytime.Find and Connect with Experts',
                onNextPressed: () {
                  _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease);
                },
                imageType: 'image',
              ),
              OnboardingScreen(
                title: 'Book Services with Ease',
                imagePath: 'assets/onboarding/Animation -booking.json',
                buttontext: 'Next',
                description:
                    'Choose a time that suits you. Direct booking with available slots. Manage your schedule efficiently.',
                onNextPressed: () {
                  _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease);
                },
                imageType: 'lottie',
              ),
              OnboardingScreen(
                title: 'Instant one-to-one and group Connections',
                imagePath: 'assets/onboarding/Animation -communication.json',
                buttontext: 'Next',
                description:
                    'Connect instantly with service providers. Enjoy seamless one-to-one communication for all your needs.',
                onNextPressed: () {
                  _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease);
                },
                imageType: 'lottie',
              ),
              OnboardingScreen(
                title: 'Find Top-rated Service Providers',
                imagePath: 'assets/onboarding/Animation - review.json',
                description:
                    'Browse and book based on ratings. Choose from a variety of services. Read reviews to make informed decisions.',
                onNextPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                },
                buttontext: 'Get Started',
                imageType: 'lottie',
              ),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.9),
            child: !onlastPage
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          onPressed: () {
                            _pageController.jumpToPage(3);
                          },
                          child: const Text(
                            "Skip",
                            style: TextStyle(
                                color: blueColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )),
                      SmoothPageIndicator(
                          onDotClicked: (index) {
                            _pageController.jumpToPage(index);
                          },
                          controller: _pageController,
                          count: 4),
                      TextButton(
                          onPressed: () {
                            _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease);
                          },
                          child: const Text(
                            "Next",
                            style: TextStyle(
                                color: blueColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  )
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blueColor,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage())),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 3.0),
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  final String title;
  final String imagePath;
  final String description;
  final Function onNextPressed;
  final String buttontext;
  final String imageType;

  const OnboardingScreen(
      {super.key,
      required this.title,
      required this.imagePath,
      required this.description,
      required this.onNextPressed,
      required this.buttontext,
      required this.imageType});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          imageType == 'lottie'
              ? Lottie.asset(imagePath, height: 400)
              : Image.asset(
                  imagePath,
                  height: 400,
                ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 16.0,
                color: primaryColor,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}

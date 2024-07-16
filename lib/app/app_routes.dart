import 'package:helperhive/screens/auth/screens/login.dart';
import 'package:helperhive/screens/auth/screens/signup.dart';
import 'package:helperhive/screens/booking/booking_details_screen.dart';
import 'package:helperhive/screens/home/onboarding_screen.dart';
import 'package:helperhive/screens/home/selection_screen.dart';
import 'package:helperhive/screens/service_search_screen.dart';
import 'package:helperhive/screens/profile/user_profile_screen.dart';
import 'package:helperhive/screens/profile/workers_profile_screen.dart';
import 'package:helperhive/screens/home/home_screen.dart';

class AppRoutes {
  static const String onBording = '/onboarding_screen';
  static const String homeRoute = '/home_screen';
  static const String loginRoute = '/login';
  static const String signupRoute = '/worker_signup';
  static const String searchScreenRoute = '/service_search_screen';
  static const String userProfileRoute = '/user_profile_screen';
  static const String workersProfileRoute = '/workers_profile_screen';
  static const String bookingRoute = '/booking_screen';
  static const String selectionRoute = '/selection_screen';
  static final routes = {
    homeRoute: (context) => const HomePage(),
    loginRoute: (context) => const LoginScreenNew(),
    signupRoute: (context) => const SignupScreen(isUser: true,),
    searchScreenRoute: (context) => const ServiceSearchScreen(),
    userProfileRoute: (context) => const UserProfileScreen(),
    workersProfileRoute: (context) => const WorkersProfileScreen(),
    bookingRoute: (context) => const BookingScreen(),
    onBording: (context) => const OnboardingScreens(),
    selectionRoute: (context) => const SelectionScreen(),
  };
}

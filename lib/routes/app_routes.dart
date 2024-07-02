import 'package:helperhive/screens/booking/booking_details_screen.dart';
import 'package:helperhive/screens/auth/loginscreen.dart';
import 'package:helperhive/screens/service_search_screen.dart';
import 'package:helperhive/screens/auth/signupscreen.dart';
import 'package:helperhive/screens/profile/user_profile_screen.dart';
import 'package:helperhive/screens/profile/workers_profile_screen.dart';
import 'package:helperhive/screens/home/home_screen.dart';

class AppRoutes {
  static const String homeRoute = '/home_screen';
  static const String loginRoute = '/loginscreen';
  static const String signupRoute = '/signupscreen';
  static const String searchScreenRoute = '/service_search_screen';
  static const String userProfileRoute = '/user_profile_screen';
  static const String workersProfileRoute = '/workers_profile_screen';
  static const String bookingRoute = '/booking_screen';
  static final routes = {
    homeRoute: (context) => const HomePage(),
    loginRoute: (context) => const LoginScreen(),
    signupRoute: (context) => const SignUpScreen(),
    searchScreenRoute: (context) => const ServiceSearchScreen(),
    userProfileRoute: (context) => const UserProfileScreen(),
    workersProfileRoute: (context) => const WorkersProfileScreen(),
    bookingRoute: (context) => const BookingScreen(),
  };
}

import 'package:helperhive/screens/booking_details_screen.dart';
import 'package:helperhive/screens/loginscreen.dart';
import 'package:helperhive/screens/service_search_screen.dart';
import 'package:helperhive/screens/signupscreen.dart';
import 'package:helperhive/screens/user_profile_screen.dart';
import 'package:helperhive/screens/workers_profile_screen.dart';

class AppRoutes {
  static const String loginRoute = '/loginscreen';
  static const String signupRoute = '/signupscreen';
  static const String searchScreenRoute = '/service_search_screen';
  static const String userProfileRoute = '/user_profile_screen';
  static const String workersProfileRoute = '/workers_profile_screen';
  static const String bookingRoute = '/booking_screen';
  static final routes = {
    loginRoute: (context) => const LoginScreen(),
    signupRoute: (context) => const SignupScreen(),
    searchScreenRoute: (context) => const ServiceSearchScreen(),
    userProfileRoute: (context) => const UserProfileScreen(),
    workersProfileRoute: (context) => const WorkersProfileScreen(),
    bookingRoute: (context) => const BookingScreen(),
  };
}

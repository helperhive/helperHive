import 'package:helperhive/screens/loginscreen.dart';
import 'package:helperhive/screens/service_search_screen.dart';
import 'package:helperhive/screens/signupscreen.dart';

class AppRoutes {
  static const String loginRoute = '/loginscreen';
  static const String signupRoute = '/signupscreen';
  static const String searchScreenRoute = '/service_search_screen';
  static final routes = {
    loginRoute: (context) => const LoginScreen(),
    signupRoute: (context) => const SignupScreen(),
    searchScreenRoute: (context) => const ServiceSearchScreen(),
  };
}

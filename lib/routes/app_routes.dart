import 'package:helperhive/screens/loginscreen.dart';
import 'package:helperhive/screens/signupscreen.dart';

class AppRoutes {
  static const String loginRoute = '/loginscreen';
  static const String signupRoute = '/signupscreen';
  static final routes = {
    loginRoute: (context) => const LoginScreen(),
    signupRoute: (context) => const SignupScreen(),
  };
}

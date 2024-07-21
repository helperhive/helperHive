import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helperhive/app/app_providers.dart';
import 'package:helperhive/firebase_options.dart';
import 'package:helperhive/screens/home/home_screen.dart';
import 'package:helperhive/screens/home/onboarding_screen.dart';
import 'package:provider/provider.dart';
import 'package:helperhive/app/app_routes.dart';
import 'package:helperhive/constants/color_them.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppProviders.providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: AppRoutes.routes,
        title: 'HelperHive',
        theme: ThemeData().copyWith(
            textTheme: GoogleFonts.dmSansTextTheme(
          Theme.of(context).textTheme,
        )),
        // home: const OnboardingScreens(),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const HomePage();
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text("error will loading the data"),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                );
              }

              return const OnboardingScreens();
            }),
      ),
    );
  }
}

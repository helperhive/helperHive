import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:helperhive/firebase_options.dart';
import 'package:helperhive/app/app_routes.dart';
import 'package:helperhive/screens/home/onboarding_screen.dart';
import 'package:provider/provider.dart';

import 'app/app_providers.dart';
import 'screens/home/home_screen.dart';

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
        // home: const OnboardingScreens(), //use this when you need the login instance are not required to save
        home: StreamBuilder(
            stream: FirebaseAuth.instance
                .authStateChanges(), // this stream builder enable you to login to the app
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
                      // color: primaryColor,
                      ),
                );
              }

              return const OnboardingScreens();
            }),
      ),
    );
  }
}

// //main.dart code with saving state
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:helperhive/firebase_options.dart';
// import 'package:helperhive/routes/app_routes.dart';
// import 'package:helperhive/screens/home/home_screen.dart';
// import 'package:helperhive/screens/home/onboarding_screen.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       routes: AppRoutes.routes,
//       title: 'HelperHive',
//       // home: const OnboardingScreens(),
//       home: StreamBuilder(
//           stream: FirebaseAuth.instance.authStateChanges(),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               return HomePage();
//             } else if (snapshot.hasError) {
//               return const Center(
//                 child: Text("error will loading the data"),
//               );
//             }
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                 child: CircularProgressIndicator(
//                     // color: primaryColor,
//                     ),
//               );
//             }

//             return const OnboardingScreens();
//           }),
//     );
//   }
// }

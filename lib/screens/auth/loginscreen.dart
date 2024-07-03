// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:helperhive/routes/app_routes.dart';
import 'package:helperhive/screens/auth/widgets/auth_text_form_field.dart';
import 'package:helperhive/backend/auth_methods.dart';
import 'package:helperhive/widgets/custum_auth_button.dart';
import 'package:helperhive/screens/auth/widgets/button_with_image.dart';
import 'package:helperhive/screens/auth/signupscreen.dart';

class LoginScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const LoginScreen({Key? key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();
  bool isPasswordVisible = false;
  bool isLoading = false;

//login using email and password
  void logIn() async {
    setState(() {
      isLoading = true;
    });

    try {
      await authService.logInWithEmailAndPassword(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      // Navigate to HomeScreen after successful login
      Navigator.pushReplacementNamed(context, '/home_screen');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign in failed: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

//login using google
  // Sign in using Google
  void signInWithGoogle() async {
    setState(() {
      isLoading = true;
    });

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        throw Exception('Google Sign-In aborted');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      await authService.handlesigninWithGoogle(userCredential);

      Navigator.of(context).pushNamed(AppRoutes.homeRoute);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue.shade200,
                Colors.blue.shade200,
                Colors.blue.shade300,
                Colors.blue.shade300,
                Colors.blue.shade200,
                Colors.blue.shade200,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 100),
              const Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),

              const SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: AuthTextFormField(
                  emailController: emailController,
                  isPassword: false,
                  labelText: 'Email',
                  icon: Icons.email,
                ),
              ),

              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: AuthTextFormField(
                  emailController: passwordController,
                  isPassword: true,
                  labelText: 'Password',
                  icon: const IconData(0xe3ae, fontFamily: 'MaterialIcons'),
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'Please enter a password with at least 6 characters';
                    }
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 25),
              isLoading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      width: 300,
                      child: CustomAuthElevatedButton(
                        text: 'Log In',
                        color: Colors.orange.shade300,
                        onPressed: logIn,
                      ),
                    ),

              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Implement your forgot password logic here
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.deepOrange),
                  ),
                ),
              ),

              const SizedBox(height: 10),
              Text(
                'Or log in with',
                style: TextStyle(color: Colors.blue.shade900),
              ),

              const SizedBox(height: 20),
              ButtonWithImage(
                image: const AssetImage('assets/logos/google_logo.jpg'),
                label: 'Login With Google',
                loginSignupFunction: signInWithGoogle,
              ),

              const SizedBox(height: 10),
              const ButtonWithImage(
                image: AssetImage('assets/logos/fb_logo.jpg'),
                label: 'Login With Facebook',
              ),

              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpScreen(),
                    ),
                  ).then((loginSuccessful) {
                    if (loginSuccessful == true) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Successfully done!'),
                          duration: Duration(seconds: 5),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please recheck and try again.'),
                          duration: Duration(seconds: 5),
                        ),
                      );
                    }
                  });
                },
                child: const Text(
                  "Don't have an account? Sign Up",
                  style: TextStyle(color: Colors.red),
                ),
              ),

              const SizedBox(
                  height: 20), // Ensure there's enough space at the bottom
            ],
          ),
        ),
      ),
    );
  }
}

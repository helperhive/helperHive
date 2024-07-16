// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:helperhive/enums/service_enum.dart';
import 'package:helperhive/app/app_routes.dart';
import 'package:helperhive/backend/auth/auth_methods.dart';
import 'package:helperhive/widgets/custum_auth_button.dart';
import 'package:helperhive/screens/auth/widgets/auth_text_form_field.dart';
import 'package:helperhive/screens/auth/widgets/button_with_image.dart';
// import 'package:helperhive/screens/auth/widgets/auth_login_signup.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final AuthService authService = AuthService();
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneNumberController = TextEditingController();
  Service? selectedService;
  bool isLoading = false;
  bool isPasswordVisible = false;

  // late SignInAndLoginService signinLogin;
  // @override
  // void initState() {
  //     super.initState();
  //     signinLogin = SignInAndLoginService(authService: authService); // Create an instance of GoogleSignInService
  //   }

  //Signin using email and password
  void signUp() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        await authService.signUpWithEmailAndPasswordforWorkers(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          name: nameController.text.trim(),
          phoneNumber: phoneNumberController.text.trim(),
          service: selectedService!,
        );
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
  }

  //  void signInWithGoogle() {
  //   signinLogin.signInWithGoogle(context);
  // }

  //Signin with Google
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

      await authService.handlesigninWithGoogleforWorkers(userCredential);

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
      body: Container(
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 100),
                  const Text(
                    "Let's Get Started!",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),

                  //Name
                  const SizedBox(height: 70),
                  AuthTextFormField(
                      emailController: nameController,
                      isPassword: false,
                      labelText: 'Name',
                      icon: const IconData(0xe043, fontFamily: 'MaterialIcons'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      }),

                  //Email
                  const SizedBox(height: 16),
                  AuthTextFormField(
                      emailController: emailController,
                      isPassword: false,
                      labelText: 'Email',
                      icon: Icons.email),

                  //Password
                  const SizedBox(height: 16),
                  AuthTextFormField(
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

                  //Phone Number
                  const SizedBox(height: 16),
                  AuthTextFormField(
                    emailController: phoneNumberController,
                    isPassword: false,
                    labelText: 'Phone Number',
                    icon: const IconData(0xe4a2, fontFamily: 'MaterialIcons'),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 10) {
                        return 'Please enter a valid phone number';
                      }
                      return null;
                    },
                  ),

                  //Drop Down Menu Bar
                  const SizedBox(height: 16),
                  DropdownButtonHideUnderline(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white60,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(Icons.menu),
                          ),
                          Expanded(
                            child: DropdownButton<Service>(
                              value: selectedService,
                              isExpanded: true,
                              hint: const Text(
                                'Select a Service',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              items: Service.values.map((service) {
                                return DropdownMenuItem<Service>(
                                  value: service,
                                  child: Row(
                                    children: [
                                      Icon(getIconForService(service)),
                                      const SizedBox(width: 10),
                                      Text(service.toString()),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (Service? newValue) {
                                setState(() {
                                  selectedService = newValue!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: 300,
                    child: isLoading
                        ? const Center(
                            child: CupertinoActivityIndicator(),
                          )
                        : CustomAuthElevatedButton(
                            text: 'Sign Up',
                            color: Colors.orange.shade300,
                            onPressed: signUp,
                          ),
                  ),

                  const SizedBox(height: 20),
                  Text('Or log in with',
                      style: TextStyle(color: Colors.blue.shade900)),
                  const SizedBox(height: 20),

                  //signin with google button
                  // const ButtonWithImage(
                  //     image: AssetImage('assets/logos/google_logo.jpg'),
                  //     label: 'SignIn With Google',
                  //     loginSignupFunction: signInWithGoogle,
                  //     ),

                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: signInWithGoogle,
                      child: Container(
                        height: 40,
                        width: 300,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.cyan.shade800,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(32),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/logos/google_logo.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'SignIn With Google',
                              style: TextStyle(
                                color: Colors.cyan.shade800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  //signin with fb button
                  const SizedBox(height: 10),
                  const ButtonWithImage(
                      image: AssetImage('assets/logos/fb_logo.jpg'),
                      label: 'SignIn With Facebook'),

                  const SizedBox(height: 15),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Already have an account? Log In",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

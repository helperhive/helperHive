import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:helperhive/app/app_routes.dart';
import 'package:helperhive/backend/auth/auth_methods.dart';
import 'package:helperhive/constants/toast.dart';
import 'package:helperhive/enums/service_enum.dart';
import 'package:helperhive/screens/auth/screens/login.dart';
import 'package:helperhive/screens/auth/widgets/auth_button.dart';
import 'package:helperhive/screens/auth/widgets/input_field.dart';
import 'package:helperhive/widgets/divider_text.dart';
import 'package:lottie/lottie.dart';

class SignupScreenNew extends StatefulWidget {
  const SignupScreenNew({super.key});

  @override
  State<SignupScreenNew> createState() => _SignupScreenNewState();
}

class _SignupScreenNewState extends State<SignupScreenNew> {
  final AuthService authService = AuthService();
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  TextEditingController serviceController = TextEditingController();
  Service? _selectedService;
  bool isLoading = false;

  void signUp() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        await authService.signUpWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          name: nameController.text.trim(),
          phoneNumber: phoneNumberController.text.trim(),
          service: _selectedService!,
        );
        Navigator.of(context).pushNamed(AppRoutes.homeRoute);
      } catch (e) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text(e.toString())),
        // );
        toastMessage(
            context: context,
            message: e.toString(),
            position: DelightSnackbarPosition.top);
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(height: 30), // Space for the top margin
                  Lottie.asset(
                    'assets/auth/signup.json',
                    height: 120,
                  ), // Image
                  const SizedBox(height: 20),
                  const Text(
                    'Create An Account',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    controller: phoneNumberController,
                    hintText: 'Enter Name',
                    // label: 'Name',
                    leadingIcon:
                        const IconData(0xe043, fontFamily: 'MaterialIcons'),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 10) {
                        return 'Please enter a valid phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    controller: emailController,
                    hintText: 'Enter Email Address',
                    // label: 'Email Address',
                    leadingIcon: Icons.email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                          .hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    controller: passwordController,
                    hintText: 'Enter Password',
                    // label: 'Password',
                    obscureText: true,
                    leadingIcon:
                        const IconData(0xe3ae, fontFamily: 'MaterialIcons'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),

                  CustomTextField(
                    controller: phoneNumberController,
                    hintText: 'Enter Phone Number',
                    // label: 'Phone Number',
                    leadingIcon:
                        const IconData(0xe4a2, fontFamily: 'MaterialIcons'),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 10) {
                        return 'Please enter a valid phone number';
                      }
                      return null;
                    },
                    formatter: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                  ),
                  // const SizedBox(height: 15),
                  // Align(
                  //   alignment: Alignment.centerLeft,
                  //   child: Text(
                  //     'Service',
                  //     style: TextStyle(
                  //       fontSize: 16,
                  //       fontWeight: FontWeight.bold,
                  //       color: Colors.grey.shade400,
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 15),

                  Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: Colors.white,
                    ),
                    child: DropdownButtonFormField<Service>(
                      value: _selectedService,
                      hint: const Text('Select Service'),
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1.5, color: Colors.blue),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        border: OutlineInputBorder(
                          gapPadding: 6,
                          borderSide:
                              const BorderSide(width: 1.5, color: Colors.black),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        disabledBorder: OutlineInputBorder(
                          gapPadding: 6,
                          borderSide:
                              const BorderSide(width: 1.5, color: Colors.black),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        enabledBorder: OutlineInputBorder(
                          gapPadding: 6,
                          borderSide:
                              const BorderSide(width: 1.5, color: Colors.black),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onChanged: (Service? newValue) {
                        setState(() {
                          _selectedService = newValue;

                          // serviceController.text = _selectedService!.toTitle();
                        });
                      },
                      items: Service.values.map((Service service) {
                        return DropdownMenuItem<Service>(
                          value: service,
                          child: Row(
                            children: [
                              Icon(getIconForService(service)),
                              const SizedBox(width: 10),
                              Text(service.toTitle()),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 20),
                  AuthButton(
                      onTap: () {
                        signUp();
                      },
                      text: 'Signup',
                      backgroundcolor: Colors.blue.shade300,
                      textColor: Colors.black,
                      isloading: false,
                      width: 250),
                  const SizedBox(height: 15),
                  // const Text('Or Continue with'),
                  const DividerWithText(
                    text: 'Or Continue with',
                    thickness: 2,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 60,
                    width: 120,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          child: const CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/auth/google_logo.jpg'),
                            radius: 25,
                          ),
                          onTap: () {
                            signInWithGoogle();
                          },
                        ),
                        GestureDetector(
                          child: const CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/auth/fb_logo.jpg'),
                            radius: 23,
                          ),
                          onTap: () {},
                        ),
                        // IconButton(
                        //   icon: Image.asset('assets/github_icon.png'),
                        //   onPressed: () {
                        //   },
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const LoginScreenNew()));
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  DropdownButton<Service> serviceDropDown() {
    return DropdownButton<Service>(
      hint: const Text('Select Service'),
      value: _selectedService,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (Service? newValue) {
        setState(() {
          _selectedService = newValue!;
          serviceController = TextEditingController(
            text: _selectedService!.toTitle(),
          );
        });
      },
      items: Service.values.map<DropdownMenuItem<Service>>((Service service) {
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
    );
  }
}

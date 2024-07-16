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

class SignupScreen extends StatefulWidget {
  final bool isUser;

  const SignupScreen({super.key, required this.isUser});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final AuthService authService = AuthService();
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  // TextEditingController serviceController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  Service? _selectedService;
  bool isLoading = false;

  void signUp() async {
    if (formKey.currentState!.validate()) {
      if (emailController.text.isEmpty ||
          passwordController.text.isEmpty ||
          nameController.text.isEmpty ||
          phoneNumberController.text.isEmpty) {
        message('Fill all the fields');
        return;
      }
      setState(() {
        isLoading = true;
      });
      String res = '';
      try {
        if (widget.isUser) {
          // User signup
          res = await authService.signUpWithEmailAndPasswordforUsers(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
            name: nameController.text.trim(),
            phoneNumber: phoneNumberController.text.trim(),
            location: locationController.text.trim(),
          );
        } else {
          // Worker signup
          res = await authService.signUpWithEmailAndPasswordforWorkers(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
            name: nameController.text.trim(),
            phoneNumber: phoneNumberController.text.trim(),
            service: _selectedService!,
          );
        }
        message(res);
        setState(() {
          isLoading = false;
        });
      } catch (e) {
        message(e.toString());
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

      if (widget.isUser) {
        await authService.handlesigninWithGoogleforUsers(userCredential);
      } else {
        await authService.handlesigninWithGoogleforWorkers(userCredential);
      }

      Navigator.of(context).pushNamed(AppRoutes.homeRoute);
    } catch (e) {
      message(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void message(String msg) {
    if (msg == 'success') {
      Navigator.of(context).pushReplacementNamed(AppRoutes.homeRoute);
    }

    toastMessage(
      context: context,
      message: msg == 'success' ? "Welcome OnBoard" : msg,
      position: DelightSnackbarPosition.top,
    );
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
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/auth/signup.json',
                      height: 120,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Create An Account',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      controller: nameController,
                      hintText: 'Enter Name',
                      leadingIcon:
                          const IconData(0xe043, fontFamily: 'MaterialIcons'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      controller: emailController,
                      hintText: 'Enter Email Address',
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
                      leadingIcon:
                          const IconData(0xe3ae, fontFamily: 'MaterialIcons'),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        } else if (value.length < 8) {
                          return 'Password must be at least 8 characters';
                        } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
                          return 'Password must contain at least one uppercase letter';
                        } else if (!RegExp(r'\d').hasMatch(value)) {
                          return 'Password must contain at least one number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      controller: phoneNumberController,
                      hintText: 'Enter Phone Number',
                      leadingIcon:
                          const IconData(0xe4a2, fontFamily: 'MaterialIcons'),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 10) {
                          return 'Please enter a valid phone number';
                        }
                        return null;
                      },
                      formatter: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                    ),
                    const SizedBox(height: 15),
                    if (widget.isUser)
                      CustomTextField(
                        controller: locationController,
                        hintText: 'Enter Location',
                        leadingIcon: Icons.location_on,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Location is required';
                          }
                          return null;
                        },
                      ),
                    if (!widget.isUser) ...[
                      // const SizedBox(height: 15),
                      serviceDropDown(context),
                    ],
                    const SizedBox(height: 20),
                    AuthButton(
                      onTap: signUp,
                      text: 'Signup',
                      backgroundcolor: Colors.blue.shade300,
                      textColor: Colors.black,
                      isloading: isLoading,
                      width: 250,
                    ),
                    const SizedBox(height: 15),
                    const DividerWithText(
                      text: 'Or Continue with',
                      thickness: 2,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: signInWithGoogle,
                            child: const CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/auth/google_logo.jpg'),
                              radius: 25,
                            ),
                          ),
                          GestureDetector(
                            child: const CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/auth/fb_logo.jpg'),
                              radius: 23,
                            ),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?'),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginScreenNew(
                                isUser: widget.isUser,
                              ),
                            ));
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Theme serviceDropDown(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.white,
      ),
      child: DropdownButtonFormField<Service>(
        value: _selectedService,
        hint: const Text('Select Service'),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1.5, color: Colors.blue),
            borderRadius: BorderRadius.circular(16),
          ),
          border: OutlineInputBorder(
            gapPadding: 6,
            borderSide: const BorderSide(width: 1.5, color: Colors.black),
            borderRadius: BorderRadius.circular(16),
          ),
          disabledBorder: OutlineInputBorder(
            gapPadding: 6,
            borderSide: const BorderSide(width: 1.5, color: Colors.black),
            borderRadius: BorderRadius.circular(16),
          ),
          enabledBorder: OutlineInputBorder(
            gapPadding: 6,
            borderSide: const BorderSide(width: 1.5, color: Colors.black),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onChanged: (Service? newValue) {
          setState(() {
            _selectedService = newValue;
          });
        },
        items: Service.values.map((Service service) {
          return DropdownMenuItem<Service>(
            value: service,
            child: service == Service.user
                ? Row(
                    children: [
                      Icon(getIconForService(service)),
                      const SizedBox(width: 10),
                      Text(service.toTitle()),
                    ],
                  )
                : const SizedBox(),
          );
        }).toList(),
      ),
    );
  }
}

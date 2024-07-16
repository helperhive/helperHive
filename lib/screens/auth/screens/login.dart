import 'package:flutter/material.dart';
import 'package:helperhive/app/app_routes.dart';
import 'package:helperhive/backend/auth/auth_methods.dart';
import 'package:helperhive/constants/toast.dart';
import 'package:helperhive/screens/auth/screens/forgot_password.dart';
import 'package:helperhive/screens/auth/screens/signup.dart';
import 'package:helperhive/screens/auth/widgets/auth_button.dart';
import 'package:helperhive/widgets/divider_text.dart';
import 'package:lottie/lottie.dart';

import '../widgets/input_field.dart';

class LoginScreenNew extends StatefulWidget {
  final bool? isUser;
  const LoginScreenNew({super.key, this.isUser});

  @override
  State<LoginScreenNew> createState() => _LoginScreenNewState();
}

class _LoginScreenNewState extends State<LoginScreenNew> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  final AuthService authService = AuthService();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void logIn() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      toastMessage(context: context, message: 'Fill the fields');
      return;
    }
    setState(() {
      isLoading = true;
    });

    String res = await authService.logInWithEmailAndPassword(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    response(res);

    setState(() {
      isLoading = false;
    });
  }

  void response(String res) {
    if (res == 'success') {
      Navigator.of(context).pushReplacementNamed(AppRoutes.homeRoute);
      return;
    }

    toastMessage(context: context, message: res);
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
                children: [
                  // const SizedBox(height: 20), // Space for the top margin
                  Lottie.asset(
                    'assets/auth/login.json',
                    height: 200,
                  ), // Image
                  const SizedBox(height: 20),
                  const Text(
                    'Welcome Back!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: emailController,
                    hintText: 'Enter Email Address',
                    label: 'Email Address',
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
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: passwordController,
                    hintText: 'Enter Password',
                    label: 'Password',
                    obscureText: true,
                    leadingIcon:
                        const IconData(0xe3ae, fontFamily: 'MaterialIcons'),
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
                  const SizedBox(height: 6),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ForgotPassword(
                                  email: emailController.text.trim(),
                                )));
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  // const SizedBox(height: 6),

                  AuthButton(
                      onTap: () => logIn(),
                      text: 'Login',
                      backgroundcolor: Colors.blue.shade300,
                      textColor: Colors.black,
                      isloading: isLoading,
                      width: 250),
                  const SizedBox(height: 25),
                  // const Text('Or Continue with'),
                  const DividerWithText(
                    text: 'Or Continue with',
                    thickness: 2,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/auth/google_logo.jpg'),
                          radius: 28,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/auth/fb_logo.jpg'),
                          radius: 25,
                        ),
                        onPressed: () {},
                      ),
                      // IconButton(
                      //   icon: Image.asset('assets/github_icon.png'),
                      //   onPressed: () {
                      //
                      //   },
                      // ),
                    ],
                  ),
                  // const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don’t have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignupScreen(
                                    isUser: widget.isUser ?? true,
                                  )));
                        },
                        child: const Text(
                          'SignUp',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
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
    );
  }
}

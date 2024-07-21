import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:helperhive/backend/auth/auth_methods.dart';
import 'package:helperhive/constants/color_them.dart';
import 'package:helperhive/constants/toast.dart';
import 'package:helperhive/screens/auth/widgets/auth_button.dart';
import 'package:helperhive/screens/auth/widgets/input_field.dart';
import 'package:lottie/lottie.dart';

class ForgotPassword extends StatefulWidget {
  final String? email;
  const ForgotPassword({super.key, this.email});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late TextEditingController emailController;
  bool isLoading = false;
  @override
  void initState() {
    emailController = TextEditingController(text: widget.email);
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void resetPassword() async {
    if (emailController.text.isEmpty) {
      message('Email is Required', navigate: false);
      return;
    }
    setState(() {
      isLoading = true;
    });

    String res = await AuthService().resetPassword(emailController.text.trim());
    message(res);

    setState(() {
      isLoading = false;
    });
  }

  void message(String res, {bool navigate = true}) {
    toastMessage(
        context: context, message: res, position: DelightSnackbarPosition.top);
    if (navigate) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueColor,
        title: const Text(
          'Reset Password',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/auth/forgot_password.json',
              height: 200,
              repeat: false,
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              textAlign: TextAlign.center,
              'Receive an Email to\nReset Your Password',
              maxLines: 2,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 40,
            ),
            CustomTextField(
              controller: emailController,
              hintText: 'Enter Email Address',
              leadingIcon: Icons.email,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return 'Enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 30,
            ),
            AuthButton(
                onTap: () => resetPassword(),
                text: 'Reset Password',
                backgroundcolor: Colors.blue,
                textColor: Colors.white,
                isloading: isLoading,
                width: 250),
          ],
        ),
      ),
    );
  }
}

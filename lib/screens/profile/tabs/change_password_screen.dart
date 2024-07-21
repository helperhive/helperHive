import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:helperhive/backend/auth/auth_methods.dart';
import 'package:helperhive/constants/toast.dart';
import 'package:helperhive/screens/auth/widgets/auth_button.dart';
import 'package:helperhive/screens/auth/widgets/input_field.dart';
import 'package:lottie/lottie.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void ChangePassword() async {
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
        title: const Text(
          'Change Password',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/auth/forgot_password.json',
              height: 150,
              repeat: false,
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              textAlign: TextAlign.center,
              'Receive an Email to\nChange Your Password',
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
                onTap: () => ChangePassword(),
                text: 'Change Password',
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

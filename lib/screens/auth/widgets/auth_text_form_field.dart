import 'package:flutter/material.dart';

class AuthTextFormField extends StatefulWidget {
  const AuthTextFormField({
    super.key,
    required this.emailController,
    this.validator,
    required this.isPassword,
    required this.labelText,
    required this.icon,
    this.suffixicon,
  });

  final TextEditingController emailController;
  final Function(String?)? validator;
  final bool isPassword;
  final String labelText;
  final IconData icon;
  final IconData? suffixicon;

  @override
  AuthTextFormFieldState createState() => AuthTextFormFieldState();
}

class AuthTextFormFieldState extends State<AuthTextFormField> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isPassword && !isPasswordVisible,
      controller: widget.emailController,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        fillColor: Colors.white60,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: Colors.grey.shade400, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(color: Colors.black45, width: 2.0),
        ),
        prefixIcon: Icon(widget.icon),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
              )
            : null,
      ),
    );
  }
}

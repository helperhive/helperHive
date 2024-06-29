import 'package:flutter/material.dart';

class CustomAuthElevatedButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Color color;
  final VoidCallback onPressed;

  const CustomAuthElevatedButton({
    super.key,
    required this.text,
    required this.color,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon != null ? Icon(icon, color: Colors.white) : Container(),
      label: Text(text),
      style: ElevatedButton.styleFrom(backgroundColor: color),
    );
  }
}

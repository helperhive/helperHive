import 'package:flutter/material.dart';

class DividerWithText extends StatelessWidget {
  final String text;
  final double? thickness;
  const DividerWithText({super.key, required this.text, this.thickness});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            thickness: thickness,
            color: Colors.grey.shade400,
            // indent: ,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            text,
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ),
        Expanded(
          child: Divider(
            thickness: thickness,
            color: Colors.grey.shade400,
          ),
        ),
      ],
    );
  }
}

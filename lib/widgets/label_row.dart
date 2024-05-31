import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helperhive/constants/color_them.dart';

class LabelRow extends StatelessWidget {
  final String labelName;
  final Function() onTap;
  const LabelRow({super.key, required this.labelName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            labelName,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: primaryColor),
          ),
          GestureDetector(
            onTap: onTap,
            child: const Text(
              "See All",
              style: TextStyle(
                  // decorationColor: blueColor,
                  // decorationThickness: 3,
                  // decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: blueColor),
            ),
          ),
        ],
      ),
    );
  }
}

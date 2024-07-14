import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatefulWidget {
  final Function() onTap;
  final String text;
  final Color backgroundcolor;
  final Color textColor;
  final bool isloading;
  final double width;
  const AuthButton(
      {super.key,
      required this.onTap,
      required this.text,
      required this.backgroundcolor,
      required this.textColor,
      required this.isloading,
      required this.width});

  @override
  State<AuthButton> createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onTap,
      style: ButtonStyle(
        // side: const WidgetStatePropertyAll(
        //   BorderSide(color: Colors.black45),
        // ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        fixedSize: WidgetStatePropertyAll(
          Size.fromWidth(widget.width),
        ),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(vertical: 10),
        ),
        backgroundColor: WidgetStatePropertyAll(widget.backgroundcolor),
      ),
      child: widget.isloading
          ? Center(
              child: CupertinoActivityIndicator(
                color: widget.textColor,
                radius: 10,
              ),
            )
          : Text(
              widget.text,
              style: TextStyle(
                  color: widget.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
    );
  }
}

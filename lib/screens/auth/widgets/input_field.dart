import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final String? label;
  final String? Function(String?)? validator;
  final IconData? leadingIcon;
  final bool? enable;
  final List<TextInputFormatter>? formatter;

  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.obscureText = false,
      this.label,
      this.validator,
      this.leadingIcon,
      this.enable,
      this.formatter});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isPasswordVisible = false;
  String? errorText;

  void validate() {
    setState(() {
      errorText = widget.validator?.call(widget.controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label ?? '',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 10),
        ],
        TextFormField(
          enabled: widget.enable ?? true,
          controller: widget.controller,
          obscureText: widget.obscureText && !isPasswordVisible,
          decoration: InputDecoration(
            focusColor: const Color.fromARGB(255, 8, 132, 163).withOpacity(0.9),

            hintText: widget.hintText,
            // labelText: widget.hintText,
            labelStyle: const TextStyle(color: Colors.black54),
            contentPadding: const EdgeInsets.only(left: 5),
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
            prefixIcon: Icon(widget.leadingIcon),
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  )
                : null,
            // errorText: errorText,
          ),
          onChanged: (text) {
            validate();
          },
          inputFormatters: widget.formatter ?? [],
          // onEditingComplete: () => validate(),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 5),
            child: Text(
              errorText!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}

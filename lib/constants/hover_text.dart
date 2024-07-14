import 'package:flutter/material.dart';

class HoverText extends StatefulWidget {
  final String text;
  final TextStyle defaultStyle;
  final TextStyle hoverStyle;
  final VoidCallback? onTap;

  const HoverText({
    super.key,
    required this.text,
    required this.defaultStyle,
    required this.hoverStyle,
    this.onTap,
  });

  @override
  State<HoverText> createState() => _HoverTextState();
}

class _HoverTextState extends State<HoverText> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: InkWell(
        onTap: widget.onTap,
        child: Text(
          widget.text,
          style: _isHovered
              ? widget.hoverStyle.copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.blue)
              : widget.defaultStyle,
        ),
      ),
    );
  }
}

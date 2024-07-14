import 'package:flutter/material.dart';

class HoverButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color? hoverColor;

  const HoverButton(
      {super.key,
      required this.onPressed,
      required this.child,
      this.hoverColor});

  @override
  State<HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      child: GestureDetector(
        onTap: () {
          widget.onPressed();
          onHover(true);
        },
        child: InkWell(
          child: Container(
            decoration: BoxDecoration(
              color: isHovered
                  ? (widget.hoverColor ?? Colors.grey[400])
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }

  void onHover(bool hover) {
    setState(() {
      isHovered = hover;
    });
  }
}

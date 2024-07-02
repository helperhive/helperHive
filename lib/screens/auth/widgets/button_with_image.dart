import 'package:flutter/material.dart';

class ButtonWithImage extends StatelessWidget {
  const ButtonWithImage({
    super.key,
    required this.image,
    required this.label,
  });

  final ImageProvider image;
  final String label;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: 40,
          width: 300,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.cyan.shade800,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(32),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                label,
                style: TextStyle(
                  color: Colors.cyan.shade800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

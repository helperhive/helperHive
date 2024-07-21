import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function()? onTap;
  final Color? labelColor;
  const DrawerItem(
      {super.key,
      required this.icon,
      required this.label,
      this.onTap,
      this.labelColor});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.blue,
        size: 24,
      ),
      title: Text(
        label,
        style: TextStyle(
            color: labelColor ?? Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
    );
  }
}

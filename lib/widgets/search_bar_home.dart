import 'package:flutter/material.dart';
import 'package:helperhive/constants/color_them.dart';

class SearchBarHome extends StatelessWidget {
  const SearchBarHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Search for service...',
          hintStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          prefixIcon: const Icon(
            Icons.search,
            size: 26,
            color: primaryColor,
          ),
          suffixIcon: GestureDetector(
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: blueColor, borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.filter_alt_outlined,
                  size: 30, color: backgroundColor),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: const Color.fromARGB(117, 192, 223, 251),
          contentPadding: const EdgeInsets.all(0),
        ),
      ),
    );
  }
}

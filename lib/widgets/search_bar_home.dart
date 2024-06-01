import 'package:flutter/material.dart';
import 'package:helperhive/constants/color_them.dart';

class SearchBarHome extends StatefulWidget {
  const SearchBarHome({
    super.key,
  });

  @override
  State<SearchBarHome> createState() => _SearchBarHomeState();
}

class _SearchBarHomeState extends State<SearchBarHome> {
  TextEditingController searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
      child: TextFormField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: 'Search for service...',
          hintStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          prefixIcon: const Icon(
            Icons.search,
            size: 26,
            color: primaryColor,
          ),
          suffixIcon: GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: blueColor, borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.filter_alt_outlined,
                  size: 30, color: Colors.white),
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

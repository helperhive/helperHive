// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:helperhive/constants/color_them.dart';

class SearchBarHome extends StatefulWidget {
  final Function(String)? onSearch;
  final Widget? suffixIcon;
  final String? searchText;
  const SearchBarHome({
    super.key,
    this.onSearch,
    this.suffixIcon,
    this.searchText,
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
        onChanged: widget.onSearch,
        controller: searchController,
        decoration: InputDecoration(
          hintText: widget.searchText ?? 'Search for service...',
          hintStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          prefixIcon: const Icon(
            Icons.search,
            size: 26,
            color: primaryColor,
          ),
          suffixIcon: widget.suffixIcon,
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

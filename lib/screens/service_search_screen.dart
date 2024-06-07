import 'package:flutter/material.dart';
import 'package:helperhive/constants/color_them.dart';
import 'package:helperhive/widgets/cards/category_filter_search.dart';
import 'package:helperhive/widgets/list_builders/service_providers.dart';
import 'package:helperhive/widgets/search_bar_home.dart';

class ServiceSearchScreen extends StatefulWidget {
  const ServiceSearchScreen({super.key});

  @override
  State<ServiceSearchScreen> createState() => _ServiceSearchScreenState();
}

class _ServiceSearchScreenState extends State<ServiceSearchScreen> {
  String selectedCategory = 'All';
  String searchQuery = '';
  bool isHovering = false;

  void selectCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.menu,
                color: primaryColor,
                size: 32,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_outlined,
                color: primaryColor,
                size: 32,
              ),
            )
          ],
        ),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: SearchBarHome(
              onSearch: updateSearchQuery,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
        child: Column(
          children: [
            // SearchBarHome(onSearch: updateSearchQuery),
            CategoryFilter(
              onSelectCategory: selectCategory,
              selectedCategory: selectedCategory,
            ),
            Expanded(
              child: ServiceProviders(
                selectedCategory: selectedCategory,
                searchQuery: searchQuery,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

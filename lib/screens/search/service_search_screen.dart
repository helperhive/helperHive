import 'package:flutter/material.dart';
import 'package:helperhive/constants/color_them.dart';
import 'package:helperhive/screens/booking/widgets/service_providers.dart';
import 'package:helperhive/screens/search/widgets/category_filter_search.dart';
import 'package:helperhive/widgets/search_bar_home.dart';

//this search bar functionality as to be dynamic
// require proper state management
class ServiceSearchScreen extends StatefulWidget {
  final String? sevice;
  const ServiceSearchScreen({super.key, this.sevice});

  @override
  State<ServiceSearchScreen> createState() => ServiceSearchScreenState();
}

class ServiceSearchScreenState extends State<ServiceSearchScreen> {
  String selectedCategory = 'All';
  String searchQuery = '';
  bool isHovering = false;

  @override
  void initState() {
    selectedCategory = widget.sevice ?? 'All';
    super.initState();
  }

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
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_outlined,
              color: primaryColor,
              size: 32,
            ),
          )
        ],
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

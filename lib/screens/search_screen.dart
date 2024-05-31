import 'package:flutter/material.dart';
import 'package:helperhive/constants/color_them.dart';
import 'package:helperhive/widgets/search_bar_home.dart';
import 'package:helperhive/widgets/top_services_list.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
        bottom: const PreferredSize(
            preferredSize: Size.fromHeight(50), child: SearchBarHome()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              RichText(
                text: const TextSpan(children: [
                  TextSpan(text: "Search for "),
                  TextSpan(text: "\"Repair Service\""),
                ]),
              ),
              const TopServicesList(
                length: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:animated_text_kit/animated_text_kit.dart';
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
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Search for  ',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    DefaultTextStyle(
                      style:
                          const TextStyle(fontSize: 22.0, color: primaryColor),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          RotateAnimatedText("\"Repair Service\""),
                          RotateAnimatedText("\"Cleaning Service\""),
                          RotateAnimatedText("\"Washing Service\""),
                          RotateAnimatedText("\"Plumbing Service\""),
                          RotateAnimatedText("\"Painting Service\""),
                        ],
                        repeatForever: true,
                        pause: const Duration(milliseconds: 1000),
                        displayFullTextOnTap: true,
                        stopPauseOnTap: true,
                      ),
                    ),
                  ],
                ),
              ),
              const TopServicesList(
                length: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

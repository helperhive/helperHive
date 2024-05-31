import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:helperhive/constants/color_them.dart';
import 'package:helperhive/widgets/book_again_card.dart';
import 'package:helperhive/widgets/book_again_list.dart';
import 'package:helperhive/widgets/categories_column.dart';
import 'package:helperhive/widgets/category_card.dart';
import 'package:helperhive/widgets/discount_card.dart';
import 'package:helperhive/widgets/discount_carousel.dart';
import 'package:helperhive/widgets/label_row.dart';
import 'package:helperhive/widgets/search_bar_home.dart';
import 'package:helperhive/widgets/service_card.dart';
import 'package:helperhive/widgets/top_services_list.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _homeAppBar(),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5,
            ),
            DiscountCarousel(),
            SizedBox(
              height: 5,
            ),
            LabelRow(labelName: "Categories"),
            SizedBox(
              height: 5,
            ),
            CategoriesColumn(),
            SizedBox(
              height: 10,
            ),
            LabelRow(labelName: 'Top Services'),
            TopServicesList(),
            SizedBox(
              height: 10,
            ),
            LabelRow(
              labelName: "Book Again",
            ),
            BookAgainList(),
          ],
        ),
      ),
    );
  }

  AppBar _homeAppBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      toolbarHeight: 65,
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            minVerticalPadding: 0,
            contentPadding: EdgeInsets.all(0),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://images.pexels.com/photos/1308881/pexels-photo-1308881.jpeg?auto=compress&cs=tinysrgb&w=600"),
            ),
            title: Text(
              'Narasimha Naidu',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            subtitle: Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.red,
                ),
                Text(
                  'Bhimavaram',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                Icon(Icons.expand_more)
              ],
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.notifications_outlined,
            color: primaryColor,
            size: 32,
          ),
        ),
        const SizedBox(
          width: 10,
        )
      ],
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(64),
        child: SearchBarHome(),
      ),
    );
  }
}

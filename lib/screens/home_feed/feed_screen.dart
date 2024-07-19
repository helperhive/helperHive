import 'package:flutter/material.dart';
import 'package:helperhive/app/app_routes.dart';
import 'package:helperhive/backend/auth/auth_methods.dart';
import 'package:helperhive/backend/providers/user_provider.dart';
import 'package:helperhive/constants/color_them.dart';
import 'package:helperhive/screens/all_services/all_categories_screen.dart';
import 'package:helperhive/screens/myBookings/my_booking_screen.dart';
import 'package:helperhive/screens/home_feed/widgets/book_again_list.dart';
import 'package:helperhive/screens/all_services/widgets/categories_column.dart';
import 'package:helperhive/screens/home_feed/widgets/discount_carousel.dart';
import 'package:helperhive/screens/home_feed/widgets/label_row.dart';
import 'package:helperhive/screens/home_feed/widgets/swiper_builder.dart';
import 'package:helperhive/screens/home_feed/widgets/top_services_list.dart';
import 'package:helperhive/screens/search/service_search_screen.dart';
import 'package:helperhive/widgets/search_bar_home.dart';
import 'package:provider/provider.dart';
// import 'package:helperhive/screens/booking/widgets/service_providers.dart';

//need to make this feed screen dynamic
class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void onSearch(String value) {}
  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      return userProvider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              key: _scaffoldKey,
              backgroundColor: Colors.white,
              appBar: _homeAppBar(userProvider),
              body: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    const DiscountCarousel(),
                    const SizedBox(
                      height: 5,
                    ),
                    LabelRow(
                      labelName: "Categories",
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) =>
                                const AllCategoriesColumn())));
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const CategoriesRow(),
                    const SizedBox(
                      height: 10,
                    ),
                    LabelRow(
                        labelName: 'My Bookings',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyBookingScreen(),
                            ),
                          );
                        }),
                    SwiperBuilder(),
                    LabelRow(
                      labelName: 'Top Services',
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ServiceSearchScreen()));
                      },
                    ),
                    const TopServicesList(
                      length: 5,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    LabelRow(
                      labelName: "Book Again",
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ServiceSearchScreen()));
                      },
                    ),
                    const BookAgainList(),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
              drawer: showDrawer(context),
            );
    });
  }

  Drawer showDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text("Vishnu Vardhan Kothapalli"),
            accountEmail: Text("vishnu@example.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage:
                  NetworkImage("https://example.com/profile_pic.jpg"),
            ),
          ),
          ListTile(
            title: const Text("Saved posts"),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Groups"),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Games"),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Settings"),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Sign Out"),
            onTap: () {
              AuthService().signOutUser();
              Navigator.of(context).pushReplacementNamed(AppRoutes.loginRoute);
            },
          ),
        ],
      ),
    );
  }

  AppBar _homeAppBar(UserProvider provider) {
    return AppBar(
      backgroundColor: backgroundColor,
      toolbarHeight: 65,
      automaticallyImplyLeading: false,
      title: GestureDetector(
        onTap: () {
          _scaffoldKey.currentState?.openDrawer();
        },
        child: ListTile(
          minVerticalPadding: 0,
          contentPadding: const EdgeInsets.all(0),
          leading: provider.user.profileUrl != ''
              ? CircleAvatar(
                  // backgroundImage: AssetImage('assets/logos/helperHive.png'),
                  backgroundImage: NetworkImage(provider.user.profileUrl),
                )
              : CircleAvatar(
                  // backgroundImage: AssetImage('assets/logos/helperHive.png'),
                  child: Text(provider.user.name[0]),
                ),
          title: Text(
            provider.user.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          subtitle: const Row(
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
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: SearchBarHome(
          onSearch: onSearch,
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
        ),
      ),
    );
  }
}

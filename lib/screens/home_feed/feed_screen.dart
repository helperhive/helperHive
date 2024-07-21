import 'package:flutter/material.dart';
import 'package:helperhive/app/app_routes.dart';
import 'package:helperhive/backend/auth/auth_methods.dart';
import 'package:helperhive/backend/providers/user_provider.dart';
import 'package:helperhive/constants/color_them.dart';
import 'package:helperhive/model/user_model.dart';
import 'package:helperhive/screens/all_services/all_categories_screen.dart';
import 'package:helperhive/screens/home_feed/widgets/drawer_item.dart';
import 'package:helperhive/screens/myBookings/screens/my_booking_screen.dart';
import 'package:helperhive/screens/home_feed/widgets/book_again_list.dart';
import 'package:helperhive/screens/all_services/widgets/categories_column.dart';
import 'package:helperhive/screens/home_feed/widgets/discount_carousel.dart';
import 'package:helperhive/screens/home_feed/widgets/label_row.dart';
import 'package:helperhive/screens/home_feed/widgets/swiper_builder.dart';
import 'package:helperhive/screens/home_feed/widgets/top_services_list.dart';
import 'package:helperhive/screens/profile/edit_profile_screen.dart';
import 'package:helperhive/screens/profile/tabs/settings_screen.dart';
import 'package:helperhive/screens/profile/user_profile_screen.dart';
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
              backgroundColor: Colors.white70,
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
                    SwiperBuilder(
                      userProvider: userProvider,
                    ),
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
              drawer: showDrawer(context, userProvider),
            );
    });
  }

  Drawer showDrawer(BuildContext context, UserProvider provider) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Colors.lightBlue),
            onDetailsPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const UserProfileScreen())),
            accountName: Text(
              provider.user.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            accountEmail: Text(
              provider.user.email,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            currentAccountPicture: provider.user.profileUrl != ''
                ? CircleAvatar(
                    backgroundImage: NetworkImage(provider.user.profileUrl),
                  )
                : CircleAvatar(
                    child: Text(
                      provider.user.name[0],
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
          ),
          DrawerItem(
            icon: Icons.calendar_month,
            label: 'My Bookings',
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const MyBookingScreen())),
          ),
          DrawerItem(
            icon: Icons.miscellaneous_services,
            label: 'Services',
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ServiceSearchScreen())),
          ),
          DrawerItem(
            icon: Icons.calendar_month,
            label: 'Edit Profile',
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const EditProfileScreen(
                    // userProvider: provider,
                    ))),
          ),
          DrawerItem(
            icon: Icons.settings,
            label: 'Services',
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SettingsScreen())),
          ),
          DrawerItem(
            icon: Icons.logout_outlined,
            label: 'Logout',
            labelColor: Colors.red,
            onTap: () => _showLogoutDialog(context),
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
                  backgroundImage: NetworkImage(provider.user.profileUrl),
                )
              : CircleAvatar(
                  child: Text(provider.user.name[0]),
                ),
          title: Text(
            provider.user.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          subtitle: Row(
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.red,
              ),
              Text(
                provider.user.location ?? 'Location',
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              const Icon(Icons.expand_more)
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

  void _showLogoutDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Are you sure you want to logout?',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue),
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          AuthService().signOutUser();
                          Navigator.of(context)
                              .pushReplacementNamed(AppRoutes.loginRoute);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}

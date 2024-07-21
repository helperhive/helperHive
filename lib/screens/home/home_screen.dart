import 'package:flutter/material.dart';
import 'package:helperhive/app/app_routes.dart';
import 'package:helperhive/backend/auth/auth_methods.dart';
import 'package:helperhive/backend/providers/service_person_provider.dart';
import 'package:helperhive/backend/providers/user_provider.dart';
import 'package:helperhive/constants/color_them.dart';
import 'package:helperhive/screens/myBookings/screens/my_booking_screen.dart';
import 'package:helperhive/screens/chats/screens/chat_view.dart';
import 'package:helperhive/screens/home_feed/feed_screen.dart';
import 'package:helperhive/screens/profile/user_profile_screen.dart';
import 'package:helperhive/screens/search/service_search_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();

    _controller = PersistentTabController(initialIndex: 0);
    userData();
  }

  userData() async {
    UserProvider userProvider = Provider.of(context, listen: false);
    ServicePersonProvider servicePersonProvider =
        Provider.of(context, listen: false);
    await userProvider.fetchUser();
    userProvider.getBookingsStream();
    servicePersonProvider.fectchServiceProviders();
  }

  List<Widget> _buildScreens() {
    return [
      const FeedScreen(),
      const ServiceSearchScreen(),
      const MyBookingScreen(),
      // const Center(child: Text("chats")),
      const ChatView(),
      UserProfileScreen(
        onTap: () {
          AuthService().signOutUser();
          Navigator.of(context).pushReplacementNamed(AppRoutes.loginRoute);
        },
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        contentPadding: 2,
        iconSize: 30,
        textStyle: const TextStyle(fontSize: 18),
        inactiveIcon: const Icon(Icons.home_outlined),
        icon: const Icon(Icons.home),
        title: "Home",
        activeColorPrimary: blueColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        contentPadding: 2,
        iconSize: 30,
        textStyle: const TextStyle(fontSize: 18),
        icon: const Icon(Icons.search),
        title: "Search",
        activeColorPrimary: blueColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        contentPadding: 2,
        iconSize: 30,
        textStyle: const TextStyle(fontSize: 18),
        inactiveIcon: const Icon(Icons.calendar_month_outlined),
        icon: const Icon(Icons.calendar_month),
        title: "Booking",
        activeColorPrimary: blueColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        contentPadding: 2,
        iconSize: 30,
        textStyle: const TextStyle(fontSize: 18),
        inactiveIcon: const Icon(Icons.chat_outlined),
        icon: const Icon(Icons.chat),
        title: "Chats",
        activeColorPrimary: blueColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        contentPadding: 2,
        iconSize: 30,
        textStyle: const TextStyle(fontSize: 18),
        inactiveIcon: const Icon(Icons.person_2_outlined),
        icon: const Icon(Icons.person),
        title: "Profile",
        activeColorPrimary: blueColor,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Consumer<UserProvider>(builder: (context, userProvider, _) {
        return userProvider.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : PersistentTabView(
                context,
                controller: _controller,
                screens: _buildScreens(),
                items: _navBarsItems(),
                confineInSafeArea: true,
                resizeToAvoidBottomInset: true,
                backgroundColor: appbarColor,
                navBarHeight: 70,
                padding:
                    const NavBarPadding.only(bottom: 10, left: 10, right: 10),
                hideNavigationBarWhenKeyboardShows: true,
                decoration: NavBarDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  colorBehindNavBar: appbarColor,
                  boxShadow: [
                    const BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                popAllScreensOnTapOfSelectedTab: true,
                popActionScreens: PopActionScreensType.all,
                itemAnimationProperties: const ItemAnimationProperties(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.ease,
                ),
                screenTransitionAnimation: const ScreenTransitionAnimation(
                  animateTabTransition: true,
                  curve: Curves.ease,
                  duration: Duration(milliseconds: 200),
                ),
                navBarStyle: NavBarStyle.style1,
              );
      }),
    );
  }
}

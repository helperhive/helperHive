import 'package:flutter/material.dart';
import 'package:helperhive/constants/color_them.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

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
  }

  List<Widget> _buildScreens() {
    return [
      Center(child: Text("Home Screen")),
      Center(child: Text("Search Screen")),
      Center(child: Text("booking")),
      Center(child: Text("chats")),
      Center(child: Text("Profile Screen")),
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
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        resizeToAvoidBottomInset: true,
        backgroundColor: backgroundColor,
        navBarHeight: 70,
        padding: const NavBarPadding.only(bottom: 10, left: 10, right: 10),
        hideNavigationBarWhenKeyboardShows: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: backgroundColor,
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
      ),
    );
  }
}

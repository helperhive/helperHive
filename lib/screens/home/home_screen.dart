import 'package:flutter/material.dart';
import 'package:helperhive/app/app_routes.dart';
import 'package:helperhive/backend/auth/auth_methods.dart';
import 'package:helperhive/backend/notification_service/notification_services.dart';
import 'package:helperhive/backend/providers/service_person_provider.dart';
import 'package:helperhive/backend/providers/user_provider.dart';
import 'package:helperhive/constants/color_them.dart';
import 'package:helperhive/enums/service_enum.dart';
import 'package:helperhive/screens/myBookings/screens/my_booking_screen.dart';
import 'package:helperhive/screens/chats/screens/chat_view.dart';
import 'package:helperhive/screens/home_feed/feed_screen.dart';
import 'package:helperhive/screens/profile/user_profile_screen.dart';
import 'package:helperhive/screens/search/service_search_screen.dart';
import 'package:provider/provider.dart';
import "package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PersistentTabController _controller;
  bool showNav = false;

  NotificationServices notificationServices = NotificationServices();
  @override
  void initState() {
    super.initState();

    _controller = PersistentTabController(initialIndex: 0);
    notificationServices.requestNotificationPermission();

    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.getDeviceToken().then((value) {
      print("Device token  $value");
    });
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
      const ServiceSearchScreen(
        service: Service.others,
      ),
      MyBookingScreen(
        navigate: (bool val) {
          setState(() {
            showNav = val;
          });
        },
      ),
      // const Center(child: Text("chats")),
      ChatView(
        navigate: (bool val) {
          setState(() {
            showNav = val;
          });
        },
      ),
      UserProfileScreen(
        onTap: () {
          AuthService().signOutUser();
          Navigator.of(context).pushReplacementNamed(AppRoutes.loginRoute);
        },
      ),
    ];
  }

  List<PersistentTabConfig> _navBarsItems() {
    final screens = _buildScreens();
    return [
      PersistentTabConfig(
        screen: screens[0],
        item: ItemConfig(
          icon: const Icon(Icons.home),
          inactiveIcon: const Icon(Icons.home_outlined),
          title: "Home",
          activeForegroundColor: blueColor,
          inactiveForegroundColor: Colors.grey[400]!,
          inactiveBackgroundColor: Colors.transparent,
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          iconSize: 28,
          activeColorSecondary: Colors.blue[100],
        ),
      ),
      PersistentTabConfig(
        screen: screens[1],
        item: ItemConfig(
          icon: const Icon(Icons.search),
          title: "Search",
          activeForegroundColor: blueColor,
          inactiveForegroundColor: Colors.grey[400]!,
          inactiveBackgroundColor: Colors.transparent,
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          iconSize: 28,
          activeColorSecondary: Colors.blue[100],
        ),
      ),
      PersistentTabConfig(
        screen: screens[2],
        item: ItemConfig(
          icon: const Icon(Icons.calendar_month),
          inactiveIcon: const Icon(Icons.calendar_month_outlined),
          title: "Booking",
          activeForegroundColor: blueColor,
          inactiveForegroundColor: Colors.grey[400]!,
          inactiveBackgroundColor: Colors.transparent,
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          iconSize: 28,
          activeColorSecondary: Colors.blue[100],
        ),
      ),
      PersistentTabConfig(
        screen: screens[3],
        item: ItemConfig(
          icon: const Icon(Icons.chat),
          inactiveIcon: const Icon(Icons.chat_outlined),
          title: "Chats",
          activeForegroundColor: blueColor,
          inactiveForegroundColor: Colors.grey[400]!,
          inactiveBackgroundColor: Colors.transparent,
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          iconSize: 28,
          activeColorSecondary: Colors.blue[100],
        ),
      ),
      PersistentTabConfig(
        screen: screens[4],
        item: ItemConfig(
          icon: const Icon(Icons.person),
          inactiveIcon: const Icon(Icons.person_2_outlined),
          title: "Profile",
          activeForegroundColor: blueColor,
          inactiveForegroundColor: Colors.grey[400]!,
          inactiveBackgroundColor: Colors.transparent,
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          iconSize: 28,
          activeColorSecondary: Colors.blue[100],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          return userProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : PersistentTabView(
                  controller: _controller,
                  tabs: _navBarsItems(),
                  navBarBuilder: (navBarConfig) => Style2BottomNavBar(
                    navBarConfig: navBarConfig,
                  ),
                  backgroundColor: backgroundColor,
                  navBarOverlap: const NavBarOverlap.none(),
                  margin: const EdgeInsets.only(bottom: 8),
                  resizeToAvoidBottomInset: true,
                  keepNavigatorHistory: true,
                  avoidBottomPadding: true,
                  stateManagement: true,
                  handleAndroidBackButtonPress: true,
                  hideNavigationBar: showNav,
                  screenTransitionAnimation: const ScreenTransitionAnimation(
                    curve: Curves.easeInOutCubic,
                    duration: Duration(milliseconds: 600),
                  ),
                );
        },
      ),
    );
  }
}

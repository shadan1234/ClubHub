import 'package:clubhub/constants/colors.dart';
import 'package:clubhub/features/auth/services/auth_service.dart';
import 'package:clubhub/features/profile/screens/profile_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  List<Widget> pages = [
    Center(
      child: Text('Home'),
    ),
    Center(
      child: Text('Explore'),
    ),
    Center(
      child: Text('Notifications'),
    ),
  ProfileScreen()
  ];
  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: AppColors.primary,
          color: AppColors.primary,
          animationDuration: Duration(milliseconds: 300),
          items: [
            Icon(
              Icons.home,
              size: 26,
              color: Colors.white,
            ),
            Icon(
              Icons.explore,
              size: 26,
              color: Colors.white,
            ),
            Icon(
              Icons.notifications,
              size: 26,
              color: Colors.white,
            ),
            Icon(
              Icons.logout,
              size: 26,
              color: Colors.white,
            ),
          ],
          onTap: updatePage),
      body: pages[_page],
    );
  }
}

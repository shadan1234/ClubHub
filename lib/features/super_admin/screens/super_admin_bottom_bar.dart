import 'package:clubhub/features/super_admin/screens/create_club_screen.dart';
import 'package:flutter/material.dart';
import 'package:clubhub/constants/colors.dart';
import 'package:clubhub/features/auth/services/auth_service.dart';
import 'package:clubhub/features/explore/screens/explore_screen.dart';
import 'package:clubhub/features/home_users/screens/home_screen.dart';
import 'package:clubhub/features/profile/screens/profile_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class SuperAdminBottomBar extends StatefulWidget {
  static const String routeName = '/super-bottom';
  const SuperAdminBottomBar({super.key});

  @override
  State<SuperAdminBottomBar> createState() => _SuperAdminBottomBarState();
}

class _SuperAdminBottomBarState extends State<SuperAdminBottomBar> {
  int _page = 0;
  List<Widget> pages = [ExploreScreen(), CreateClubScreen(), ProfileScreen()];
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
              Icons.explore,
              size: 26,
              color: Colors.white,
            ),
            Icon(
              Icons.create,
              size: 26,
              color: Colors.white,
            ),
            Icon(
              Icons.person,
              size: 26,
              color: Colors.white,
            ),
          ],
          onTap: updatePage),
      body: pages[_page],
    );
  }
}

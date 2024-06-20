import 'package:clubhub/constants/colors.dart';
import 'package:clubhub/features/explore/screens/explore_screen.dart';
import 'package:clubhub/features/profile/screens/profile_screen.dart';
import 'package:clubhub/features/super_admin/screens/create_club_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class ClubManagerBottomBar extends StatefulWidget {
   static const String routeName = '/club-manager-bottom';
  const ClubManagerBottomBar({super.key});

  @override
  State<ClubManagerBottomBar> createState() => _ClubManagerBottomBarState();
}

class _ClubManagerBottomBarState extends State<ClubManagerBottomBar> {
   int _page = 0;
  List<Widget> pages = [ProfileScreen()];
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
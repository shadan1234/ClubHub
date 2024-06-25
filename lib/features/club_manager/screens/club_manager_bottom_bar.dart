import 'package:clubhub/constants/colors.dart';
import 'package:clubhub/features/club_manager/screens/application_screen.dart';
import 'package:clubhub/features/club_manager/screens/workspace.dart';
import 'package:clubhub/features/club_manager/screens/notification.dart';
import 'package:clubhub/features/profile/screens/profile_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class ClubManagerBottomBar extends StatefulWidget {
   static const String routeName = '/club-manager-bottom';
   final String clubId;
  const ClubManagerBottomBar({super.key, required this.clubId});

  @override
  State<ClubManagerBottomBar> createState() => _ClubManagerBottomBarState();
}

class _ClubManagerBottomBarState extends State<ClubManagerBottomBar> {
 int _page = 0;
  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = [
      const WorkSpaceClubManager(),
      ClubManagerApplicationsScreen(clubId: widget.clubId),
      ClubManagerNotificationScreen(),
      const ProfileScreen(),
    ];
  }
  
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
          animationDuration: const Duration(milliseconds: 300),
          items: const [
            Icon(
              Icons.group_add ,
              size: 26,
              color: Colors.white,
            ),
            Icon(
              Icons.assignment ,
              size: 26,
              color: Colors.white,
            ),
            Icon(
              Icons.send,
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
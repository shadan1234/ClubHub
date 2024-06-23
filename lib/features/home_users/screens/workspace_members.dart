import 'package:flutter/material.dart';
import 'package:clubhub/constants/colors.dart';
import 'package:clubhub/features/home_users/screens/teams_screen_users.dart';

class WorkSpaceMembers extends StatefulWidget {
  final String clubId;
  static const String routeName = '/members-workSpace';

  WorkSpaceMembers({
    Key? key,
    required this.clubId,
  }) : super(key: key);

  @override
  State<WorkSpaceMembers> createState() => _WorkSpaceMembersState();
}

class _WorkSpaceMembersState extends State<WorkSpaceMembers>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary, // Set primary color for the app bar
        title: Text(
          'Club Activities',
          style: TextStyle(color: Colors.white), // Title text color
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white, // Selected tab label color
          unselectedLabelColor: Colors.white.withOpacity(0.7), // Unselected tab label color
          
          tabs: [
            Tab(text: 'Teams'),
            Tab(text: 'Messaging'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          TeamsMemberScreen(clubId: widget.clubId),
          // Add more TabBarView children for each tab
          // Example: MessagingScreen(),
        ],
      ),
    );
  }
}

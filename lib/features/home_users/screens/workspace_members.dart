import 'package:clubhub/features/messaging_common.dart';
import 'package:flutter/material.dart';
import 'package:clubhub/constants/colors.dart';
import 'package:clubhub/features/home_users/screens/teams_screen_users.dart';

class WorkSpaceMembers extends StatefulWidget {
  final String clubId;
  static const String routeName = '/members-workSpace';

  const WorkSpaceMembers({
    super.key,
    required this.clubId,
  });

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
        backgroundColor: AppColors.primary, 
        title: const Text(
          'Club Activities',
          style: TextStyle(color: Colors.white), 
        ),
        bottom: TabBar(

          controller: _tabController,
          labelColor: Colors.white, 
          unselectedLabelColor: Colors.white.withOpacity(0.7), 
          
          tabs: const [
            Tab(text: 'Teams'),
            Tab(text: 'Messaging'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          TeamsMemberScreen(clubId: widget.clubId),
          MessagingScreen(
            clubId: widget.clubId,
          )
        ],
      ),
    );
  }
}

// ignore_for_file: library_private_types_in_public_api

import 'package:clubhub/constants/colors.dart';
import 'package:clubhub/features/club_manager/screens/create_team_tab.dart';
import 'package:clubhub/features/club_manager/screens/view_tab.dart';
import 'package:clubhub/features/messaging_common.dart';
import 'package:clubhub/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class WorkSpaceClubManager extends StatefulWidget {
  static const String routeName='/workspace-screen';

  const WorkSpaceClubManager({super.key});
  @override
  _WorkSpaceClubManagerState createState() => _WorkSpaceClubManagerState();
}

class _WorkSpaceClubManagerState extends State<WorkSpaceClubManager> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('Team Management'),
        bottom: TabBar(
           labelColor: Colors.white, 
          unselectedLabelColor: Colors.white.withOpacity(0.7), 
          
          controller: _tabController,
          tabs: const [
            Tab(text: 'Create Team'),
            Tab(text: 'View Teams'),
            Tab(text:'Messaging')
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          CreateTeamTab(clubId: userProvider.user.clubOwned),
          ViewTeamsTab(clubId: userProvider.user.clubOwned),
          MessagingScreen(
            clubId: userProvider.user.clubOwned,
          )
        ],
      ),
    );
  }
}



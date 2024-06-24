import 'package:clubhub/commons/widgets/custom_textfield.dart';
import 'package:clubhub/commons/widgets/textfiled_clubs.dart';
import 'package:clubhub/constants/colors.dart';
import 'package:clubhub/features/club_manager/screens/create_team_tab.dart';
import 'package:clubhub/features/club_manager/screens/view_tab.dart';
import 'package:clubhub/features/club_manager/service/teams_service.dart';
import 'package:clubhub/features/messaging_common.dart';
import 'package:clubhub/models/teams.dart';
import 'package:clubhub/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/user.dart';

class WorkSpaceClubManager extends StatefulWidget {
  static const String routeName='/workspace-screen';
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
        title: Text('Team Management'),
        bottom: TabBar(
           labelColor: Colors.white, 
          unselectedLabelColor: Colors.white.withOpacity(0.7), 
          
          controller: _tabController,
          tabs: [
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



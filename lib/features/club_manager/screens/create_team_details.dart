
import 'package:clubhub/commons/widgets/custom_textfield.dart';
import 'package:clubhub/commons/widgets/textfiled_clubs.dart';
import 'package:clubhub/constants/colors.dart';
import 'package:clubhub/features/club_manager/service/teams_service.dart';
import 'package:clubhub/models/teams.dart';
import 'package:clubhub/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/user.dart';
class CreateTeamDetails extends StatelessWidget {
  static const String routeName='/create-team-details-screen';
  final List<String> selectedUserIds;
  final String clubId;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController topicController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  TeamsService teamsService = TeamsService();

  CreateTeamDetails({
    required this.selectedUserIds,
    required this.clubId,
  });

  void createTeam(BuildContext context) async {
    await teamsService.createTeam(
      context: context,
      name: nameController.text,
      topic: topicController.text,
      description: descriptionController.text,
      users: selectedUserIds,
      clubId: clubId,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      appBar: AppBar(
         backgroundColor: AppColors.primary,
        title: Text('Team Details')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFieldClubs(labelText: 'Team Name', controller: nameController),
            SizedBox(height: 8),
            TextFieldClubs(labelText: 'Project Topic', controller: topicController),
            SizedBox(height: 8),
            TextFieldClubs(labelText: 'Project Description', controller: descriptionController),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                createTeam(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text('Create Team', style: TextStyle(fontSize: 16,color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}


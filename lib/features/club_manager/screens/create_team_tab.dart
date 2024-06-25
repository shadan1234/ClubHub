// ignore_for_file: library_private_types_in_public_api

import 'package:clubhub/constants/colors.dart';
import 'package:clubhub/features/club_manager/screens/create_team_details.dart';
import 'package:clubhub/features/club_manager/service/teams_service.dart';
import 'package:flutter/material.dart';

import '../../../models/user.dart';
class CreateTeamTab extends StatefulWidget {
  final String clubId;

  const CreateTeamTab({super.key, required this.clubId});

  @override
  _CreateTeamTabState createState() => _CreateTeamTabState();
}

class _CreateTeamTabState extends State<CreateTeamTab> {
  List<User> users = [];
  List<String> selectedUserIds = [];
  TeamsService teamsService = TeamsService();

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  void fetchUsers() async {
    users = await teamsService.fetchUsersOfTheClub(context: context, clubId: widget.clubId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return CheckboxListTile(
                  title: Text(user.name),
                  value: selectedUserIds.contains(user.id),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        selectedUserIds.add(user.id);
                      } else {
                        selectedUserIds.remove(user.id);
                      }
                    });
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, CreateTeamDetails.routeName,arguments: {'selectedUserIds' :selectedUserIds, 'clubId': widget.clubId} );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor : AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text('Next', style: TextStyle(fontSize: 16,color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
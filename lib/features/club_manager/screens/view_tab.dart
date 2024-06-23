import 'package:clubhub/commons/widgets/custom_textfield.dart';
import 'package:clubhub/commons/widgets/textfiled_clubs.dart';
import 'package:clubhub/constants/colors.dart';
import 'package:clubhub/features/club_manager/service/teams_service.dart';
import 'package:clubhub/models/teams.dart';
import 'package:clubhub/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/user.dart';

Future<List<Team>> fetchTeams(String clubId, BuildContext context) async {
  List<Team> teams = await TeamsService().fetchTeams(context: context, clubId: clubId);
  return teams;
}

class ViewTeamsTab extends StatelessWidget {
  final String clubId;

  ViewTeamsTab({required this.clubId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchTeams(clubId, context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error fetching teams'));
        } else {
          final teams = snapshot.data as List<Team>;
          return ListView.builder(
            itemCount: teams.length,
            itemBuilder: (context, index) {
              final team = teams[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(team.name, style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Topic: ${team.topic}', style: TextStyle(color: Colors.grey[700])),
                        Text('Description: ${team.description}', style: TextStyle(color: Colors.grey[700])),
                        Text('Team Members: ${team.users.map((user) => user.name).join(', ')}'),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}


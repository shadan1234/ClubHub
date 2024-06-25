import 'package:clubhub/features/club_manager/service/teams_service.dart';
import 'package:clubhub/models/teams.dart';
import 'package:flutter/material.dart';


Future<List<Team>> fetchTeamsForMembers(String clubId, BuildContext context) async {
  List<Team> teams = await TeamsService().fetchTeamsForMemberss(context: context, clubId: clubId);
  return teams;
}

class TeamsMemberScreen extends StatelessWidget {
  final String clubId;

  const TeamsMemberScreen({super.key, required this.clubId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchTeamsForMembers(clubId, context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error fetching teams'));
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
                    title: Text(team.name, style: const TextStyle(fontWeight: FontWeight.bold)),
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


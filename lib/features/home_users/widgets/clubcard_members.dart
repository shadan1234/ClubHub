import 'package:clubhub/features/home_users/screens/workspace_members.dart';
import 'package:flutter/material.dart';
import 'package:clubhub/models/club.dart';

class ClubCardMembers extends StatelessWidget {
  final Club club;

  const ClubCardMembers({super.key, required this.club});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.network(
              club.image,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  club.nameOfClub,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Type: ${club.type}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  club.description.length > 80
                      ? '${club.description.substring(0, 80)}...'
                      : club.description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, WorkSpaceMembers.routeName, arguments: club.id);
                    },
                    child: const Text('WorkSpace'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

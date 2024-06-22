import 'package:clubhub/features/club_manager/service/notification_service.dart';
import 'package:clubhub/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clubhub/models/user.dart';


class ClubManagerNotificationScreen extends StatefulWidget {
  static const String routeName='/notification-screen';
  @override
  _ClubManagerNotificationScreenState createState() => _ClubManagerNotificationScreenState();
}

class _ClubManagerNotificationScreenState extends State<ClubManagerNotificationScreen> {
  String _selectedType = 'general';
  final TextEditingController _messageController = TextEditingController();
   final TextEditingController _titleController = TextEditingController();
 
  NotificationService _notificationService = NotificationService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
  
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Message'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: Text('General'),
                  selected: _selectedType == 'general',
                  onSelected: (bool selected) {
                    setState(() {
                      _selectedType = 'general';
                    });
                  },
                ),
                SizedBox(width: 8),
                ChoiceChip(
                  label: Text('Club Members'),
                  selected: _selectedType == 'club-specific',
                  onSelected: (bool selected) {
                    setState(() {
                      _selectedType = 'club-specific';
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              maxLines: 1,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _messageController,
              decoration: InputDecoration(
                labelText: 'Message',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await _notificationService.sendNotification(context: context, recipientType: _selectedType, message: _messageController.text, title: _titleController.text, clubId: user.clubOwned
                 
                );
              },
              child: Text('Send Message'),
            ),
          ],
        ),
      ),
    );
  }
}

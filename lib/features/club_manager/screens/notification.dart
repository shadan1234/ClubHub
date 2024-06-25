import 'package:clubhub/features/club_manager/service/notification_service.dart';
import 'package:clubhub/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


// ignore: use_key_in_widget_constructors
class ClubManagerNotificationScreen extends StatefulWidget {
  static const String routeName='/notification-screen';
  @override
  // ignore: library_private_types_in_public_api
  _ClubManagerNotificationScreenState createState() => _ClubManagerNotificationScreenState();
}

class _ClubManagerNotificationScreenState extends State<ClubManagerNotificationScreen> {
  String _selectedType = 'general';
  final TextEditingController _messageController = TextEditingController();
   final TextEditingController _titleController = TextEditingController();
 
  final NotificationService _notificationService = NotificationService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
  
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Message'),
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
                  label: const Text('General'),
                  selected: _selectedType == 'general',
                  onSelected: (bool selected) {
                    setState(() {
                      _selectedType = 'general';
                    });
                  },
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('Club Members'),
                  selected: _selectedType == 'club-specific',
                  onSelected: (bool selected) {
                    setState(() {
                      _selectedType = 'club-specific';
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              maxLines: 1,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                labelText: 'Message',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await _notificationService.sendNotification(context: context, recipientType: _selectedType, message: _messageController.text, title: _titleController.text, clubId: user.clubOwned
                 
                );
              },
              child: const Text('Send Message'),
            ),
          ],
        ),
      ),
    );
  }
}

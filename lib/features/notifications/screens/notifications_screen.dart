import 'package:clubhub/features/club_manager/service/notification_service.dart';
import 'package:clubhub/models/notification.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationModel>? notifications;
  NotificationService notificationService=NotificationService(); 
  @override
  void initState() {
   _fetchNotifications();
    super.initState();
  }
  Future<void> _fetchNotifications() async {
       notifications=await notificationService.fetchNotifications(context: context);
       setState(() {
         
       });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body:notifications==null? Center(child: CircularProgressIndicator(),): ListView.builder(
        itemCount: notifications!.length,
        itemBuilder: (context, index) {
          final notification = notifications![index];
          return Card(
            child: ListTile(
            
              title: Text(notification.title),
              subtitle: Text(notification.message),
            ),
          );
        },
      ),
    );
  }
}

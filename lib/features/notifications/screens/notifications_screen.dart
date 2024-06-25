import 'package:clubhub/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:clubhub/features/club_manager/service/notification_service.dart';
import 'package:clubhub/models/notification.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationModel>? notifications;
  NotificationService notificationService = NotificationService();

  @override
  void initState() {
    _fetchNotifications();
    super.initState();
  }

  Future<void> _fetchNotifications() async {
    notifications = await notificationService.fetchNotifications(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        elevation: 0,
      ),
      body: notifications == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: notifications!.length,
              itemBuilder: (context, index) {
                final notification = notifications![index];
                return Center(
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9, // Set width to 90% of screen width
                      child: AspectRatio(
                        aspectRatio: 3 / 1, // Adjust the aspect ratio to your preference
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(15),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              notification.image,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            notification.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black87,
                            ),
                          ),
                          subtitle: Text(
                            notification.message,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

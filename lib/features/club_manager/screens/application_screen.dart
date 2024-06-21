import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // Import intl package for date formatting
import 'package:clubhub/constants/colors.dart';
import 'package:clubhub/commons/services/club_application_services.dart';
import 'package:clubhub/models/applications.dart';
import 'package:clubhub/providers/user_provider.dart';

class ClubManagerApplicationsScreen extends StatefulWidget {
  static const String routeName = '/club-manager-application-screen';
  final String clubId;

  ClubManagerApplicationsScreen({Key? key, required this.clubId})
      : super(key: key);

  @override
  _ClubManagerApplicationsScreenState createState() =>
      _ClubManagerApplicationsScreenState();
}

class _ClubManagerApplicationsScreenState
    extends State<ClubManagerApplicationsScreen> {
  List<Application> applications = [];
  bool isLoading = true;
  ClubApplicationServices clubApplicationServices = ClubApplicationServices();

  @override
  void initState() {
    super.initState();
    fetchApplications();
  }

  void fetchApplications() async {
    try {
      final fetchedApplications =
          await clubApplicationServices.fetchApplicationsForClub(
              context, widget.clubId);
      setState(() {
        applications = fetchedApplications;
        isLoading = false;
      });
    } catch (e) {
      // Handle error
      setState(() {
        isLoading = false;
      });
    }
  }

  void acceptApplication(String applicationId) async {
    try {
      await clubApplicationServices.acceptApplication(context, applicationId);
      setState(() {
        applications = applications.map((app) {
          if (app.id == applicationId) {
            app.status = 'accepted';
          }
          return app;
        }).toList();
      });
    } catch (e) {
      // Handle error
    }
  }

  void rejectApplication(String applicationId) async {
    try {
      await clubApplicationServices.rejectApplication(context, applicationId);
      setState(() {
        applications = applications.map((app) {
          if (app.id == applicationId) {
            app.status = 'rejected';
          }
          return app;
        }).toList();
      });
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Applications'),
        backgroundColor: AppColors.primary,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: applications.length,
              itemBuilder: (context, index) {
                final application = applications[index];
                // Format applied date to show only year, month, and day
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(application.appliedAt);
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Applicant: ${application.name}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Applied Date: $formattedDate',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    subtitle: Text('Status: ${application.status}'),
                    trailing: application.status == 'pending'
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.check, color: Colors.green),
                                onPressed: () =>
                                    acceptApplication(application.id),
                              ),
                              IconButton(
                                icon: Icon(Icons.close, color: Colors.red),
                                onPressed: () =>
                                    rejectApplication(application.id),
                              ),
                            ],
                          )
                        : null,
                  ),
                );
              },
            ),
    );
  }
}

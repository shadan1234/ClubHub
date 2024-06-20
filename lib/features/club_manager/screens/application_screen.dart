// import 'package:flutter/material.dart';
// import 'package:clubhub/constants/colors.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class ClubManagerApplicationsScreen extends StatefulWidget {
//   final String clubId;

//   ClubManagerApplicationsScreen({super.key, required this.clubId});

//   @override
//   _ClubManagerApplicationsScreenState createState() => _ClubManagerApplicationsScreenState();
// }

// class _ClubManagerApplicationsScreenState extends State<ClubManagerApplicationsScreen> {
//   List<Application> applications = [];
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchApplications();
//   }

//   void fetchApplications() async {
//     final uri = 'YOUR_BACKEND_URI';
//     final response = await http.get(
//       Uri.parse('$uri/api/applications/${widget.clubId}'),
//       headers: {
//         'Content-Type': 'application/json',
//         'x-auth-token': 'MANAGER_AUTH_TOKEN', // Pass the manager auth token
//       },
//     );

//     if (response.statusCode == 200) {
//       final List<Application> fetchedApplications = (json.decode(response.body) as List)
//           .map((data) => Application.fromJson(data))
//           .toList();
//       setState(() {
//         applications = fetchedApplications;
//         isLoading = false;
//       });
//     } else {
//       // Handle error
//     }
//   }

//   void acceptApplication(String applicationId) async {
//     final uri = 'YOUR_BACKEND_URI';
//     final response = await http.post(
//       Uri.parse('$uri/api/applications/$applicationId/accept'),
//       headers: {
//         'Content-Type': 'application/json',
//         'x-auth-token': 'MANAGER_AUTH_TOKEN',
//       },
//     );

//     if (response.statusCode == 200) {
//       setState(() {
//         applications = applications.map((app) {
//           if (app?.id == applicationId) {
//             app?.status = 'accepted';
//           }
//           return app;
//         }).toList();
//       });
//     } else {
//       // Handle error
//     }
//   }

//   void rejectApplication(String applicationId) async {
//     final uri = 'YOUR_BACKEND_URI';
//     final response = await http.post(
//       Uri.parse('$uri/api/applications/$applicationId/reject'),
//       headers: {
//         'Content-Type': 'application/json',
//         'x-auth-token': 'MANAGER_AUTH_TOKEN',
//       },
//     );

//     if (response.statusCode == 200) {
//       setState(() {
//         applications = applications.map((app) {
//           if (app.id == applicationId) {
//             app.status = 'rejected';
//           }
//           return app;
//         }).toList();
//       });
//     } else {
//       // Handle error
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Applications'),
//         backgroundColor: AppColors.primary,
//       ),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: applications.length,
//               itemBuilder: (context, index) {
//                 final application = applications[index];
//                 return Card(
//                   margin: EdgeInsets.all(10),
//                   child: ListTile(
//                     title: Text(application.userId.name),
//                     subtitle: Text('Status: ${application.status}'),
//                     trailing: application.status == 'pending'
//                         ? Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               IconButton(
//                                 icon: Icon(Icons.check, color: Colors.green),
//                                 onPressed: () => acceptApplication(application.id),
//                               ),
//                               IconButton(
//                                 icon: Icon(Icons.close, color: Colors.red),
//                                 onPressed: () => rejectApplication(application.id),
//                               ),
//                             ],
//                           )
//                         : null,
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

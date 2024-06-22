import 'dart:convert';
import 'package:clubhub/constants/error_handling.dart';
import 'package:clubhub/constants/global.dart';
import 'package:clubhub/models/applications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:clubhub/providers/user_provider.dart';

import 'package:clubhub/models/club.dart';
import 'package:clubhub/constants/utils.dart';

class ClubApplicationServices {
  // Existing methods...

  // Apply for a club
  void applyForClub({required BuildContext context, required String clubId ,required String name}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final response = await http.post(
      Uri.parse('$uri/apply'),
      headers: {
        'Content-Type': 'application/json',
        'x-auth-token': userProvider.user.token,
      },
      body: json.encode({
        'clubId': clubId,
        'name':name
      }),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Application submitted successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit application.')),
      );
    }
  }

  // Fetch applications for a club
  Future<List<Application>> fetchApplicationsForClub(BuildContext context, String clubId) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final response = await http.get(
      Uri.parse('$uri/applications/$clubId'),
      headers: {
        'Content-Type': 'application/json',
        'x-auth-token': userProvider.user.token,
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> applicationsJson = json.decode(response.body);
     
      final ans= applicationsJson.map((json) => Application.fromMap(json)).toList();
      
      return ans;
    } else {
       showSnackBar(context, 'Failed to load applications');
       throw Exception('Error');
    }
  }

  // Accept an application
  Future<void> acceptApplication(BuildContext context, String applicationId) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final response = await http.post(
      Uri.parse('$uri/applications/$applicationId/accept'),
      headers: {
        'Content-Type': 'application/json',
        'x-auth-token': userProvider.user.token,
      },
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Application accepted!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to accept application.')),
      );
    }
  }

  // Reject an application
  Future<void> rejectApplication(BuildContext context, String applicationId) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final response = await http.post(
      Uri.parse('$uri/applications/$applicationId/reject'),
      headers: {
        'Content-Type': 'application/json',
        'x-auth-token': userProvider.user.token,
      },
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Application rejected!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to reject application.')),
      );
    }
  }

}

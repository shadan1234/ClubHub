import 'dart:convert';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
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
  void applyForClub(
      {required BuildContext context,
      required File file,
      required String description,
      required String clubId,
      required String name}) async {


    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final CloudinaryPublic cloudinary =
        CloudinaryPublic('dwkaqsoto', 'daqdvyep');
 String document = '';
      print('mff');
    CloudinaryResponse res = await cloudinary.uploadFile(
      CloudinaryFile.fromFile(file.path,
          folder: userProvider.user.id, resourceType: CloudinaryResourceType.Auto),
    );

      document=(res.secureUrl);
      print(document);

     Application application=Application(id: '', userId: '' , clubId: clubId, status: '', appliedAt: DateTime.now(), name: name, description: description, document: document);

    final response = await http.post(
      Uri.parse('$uri/apply'),
      headers: {
        'Content-Type': 'application/json',
        'x-auth-token': userProvider.user.token,
      },
      body: application.toJson()
    );
    print(response.body);

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


  Future<List<Application>> fetchApplicationsForClub(
      BuildContext context, String clubId) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final response = await http.get(
      Uri.parse('$uri/applications/$clubId'),
      headers: {
        'Content-Type': 'application/json',
        'x-auth-token': userProvider.user.token,
      },
    );
 print(response.body);
    if (response.statusCode == 200) {
      List<dynamic> applicationsJson = json.decode(response.body);
print(applicationsJson);
    List<Application> ans = applicationsJson.map((json) {
  try {
    if (json is Map<String, dynamic>) {
      return Application.fromMap(json);
    } else {
      print('Unexpected JSON format: $json');
      return null;
    }
  } catch (e) {
    print('Error converting JSON to Application: $e');
    return null;
  }
}).whereType<Application>().toList();

      return ans;
    } else {
      showSnackBar(context, 'Failed to load applications');
      throw Exception('Error');
    }
  }

  // Accept an application
  Future<void> acceptApplication(
      BuildContext context, String applicationId) async {
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
  Future<void> rejectApplication(
      BuildContext context, String applicationId) async {
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

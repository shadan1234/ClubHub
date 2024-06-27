// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:clubhub/constants/error_handling.dart';
import 'package:clubhub/constants/global.dart';
import 'package:clubhub/constants/utils.dart';
import 'package:clubhub/features/auth/services/auth_service.dart';
import 'package:clubhub/models/club.dart';
import 'package:clubhub/providers/user_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ClubServices {
  AuthService authService=AuthService();

  Future<List<Club>> fetchAllClubs() async {
    List<Club> clubs = [];
    http.Response res = await http
        .get(Uri.parse('$uri/api/all-clubs'),
         headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
   
    if (res.statusCode == 200) {
      final jsonResponse = jsonDecode(res.body);
      if (jsonResponse['clubs'] != null) {
        for (var clubJson in jsonResponse['clubs']) {
          clubs.add(Club.fromMap(clubJson));
        }
      }
    } else {
      throw Exception('Failed to load clubs');
    }

    return clubs;
  }
    Future<List<Club>> fetchClubsForUser({
    required BuildContext context,
    
  }) async { final userProvider = Provider.of<UserProvider>(context, listen: false);
  List<Club>clubs=[];
  try {
    final response = await http.get(Uri.parse('$uri/fetch-user-clubs'), 
        headers: {
        'Content-Type': 'application/json',
        'x-auth-token': userProvider.user.token,
      },
        );
        // print(response.body);
        if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['clubs'] != null) {
        for (var clubJson in jsonResponse['clubs']) {
          clubs.add(Club.fromMap(clubJson));
        }
      }
    } 

   
        httpErrorHandle(response: response, context: context, onSuccess: (){});
  } catch (e) {
    showSnackBar(context, e.toString());
  }
    return clubs;
  }
  Future<void> createClub({
    required BuildContext context,
    required String nameOfClub,
    required String type,
    required String description,
    required File image,
    required String emailManager,
    required String passwordManager,
    required String nameManager,
  }) async {
      String? token = await FirebaseMessaging.instance.getToken();
      print(token);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('dwkaqsoto', 'daqdvyep');
      String imageUrl = '';

      CloudinaryResponse res = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(image.path, folder: nameOfClub),
      );
      imageUrl = res.secureUrl;
// print(imageUrl);

    
      final body = {
        'nameOfClub': nameOfClub,
        'type': type,
        'description': description,
        'image': imageUrl,
        'emailManager': emailManager,
        'passwordManager': passwordManager,
        'nameManager': nameManager,
         'fcmToken':token??""
      };

      final response = await http.post(
        Uri.parse('$uri/create-club-manager'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode(body),
      );
//  print(response.body);
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Club and manager created successfully!')),
        );
      } else {
        httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {},
        );
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
  }

 
}

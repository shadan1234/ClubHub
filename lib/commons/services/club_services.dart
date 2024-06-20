import 'dart:convert';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:clubhub/constants/error_handling.dart';
import 'package:clubhub/constants/global.dart';
import 'package:clubhub/constants/utils.dart';
import 'package:clubhub/features/auth/services/auth_service.dart';
import 'package:clubhub/models/club.dart';
import 'package:clubhub/providers/user_provider.dart';
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
    print(res.body);
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
  Future<void> createClub({
    required BuildContext context,
    required String nameOfClub,
    required String type,
    required String description,
    required File image,
    required String emailManager,
    required String passwordManager,
    required String nameManager
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('dwkaqsoto', 'daqdvyep');
      String imageUrl = '';

      CloudinaryResponse res = await cloudinary
          .uploadFile(CloudinaryFile.fromFile(image.path, folder: nameOfClub));
      imageUrl = res.secureUrl;

      Club club = Club(
        description: description,
        image: imageUrl,
        nameOfClub: nameOfClub,
        type: type,
        workDoneByClub: '',
        id: '',
      );
  print(imageUrl);
      http.Response response = await http.post(
        Uri.parse('$uri/create-club'),
        headers: <String, String>{
        
      'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: club.toJson(),
      );
      print(response.body);
      if (response.statusCode == 200) {
        String id = Club.fromJson(response.body).id;

        // Update the user with the club ID
        await authService.signUpUser(
          context: context,
        
          type: 'club-manager',
          email: emailManager,
          password: passwordManager,
          name: nameManager,
          idOfClub: id,
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
  void applyForClub({required BuildContext context, required String id}) async {
     final userProvider = Provider.of<UserProvider>(context, listen: false);
    final response = await http.post(
      Uri.parse('$uri/api/apply'),
      headers: {
        'Content-Type': 'application/json',
        'x-auth-token': userProvider.user.token, 
      },
      body: json.encode({
        'clubId': id,
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
}

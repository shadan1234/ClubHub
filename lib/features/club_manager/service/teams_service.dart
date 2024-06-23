import 'dart:convert';
import 'package:clubhub/constants/error_handling.dart';
import 'package:clubhub/constants/global.dart';
import 'package:clubhub/constants/utils.dart';
import 'package:clubhub/models/teams.dart';
import 'package:clubhub/models/user.dart';
import 'package:clubhub/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class TeamsService {
  Future<List<User>> fetchUsersOfTheClub({
    required BuildContext context,
    required String clubId,
  }) async {
    List<User> users = [];
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      
      http.Response res = await http.get(
        Uri.parse('$uri/fetch-all-users-of-club/$clubId'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'x-auth-token': userProvider.user.token,
        },
      );
     
      List<dynamic> decodeJson = jsonDecode(res.body);
      users = decodeJson.map((unit) => User.fromMap(unit as Map<String, dynamic>)).toList();
      print(users);
      httpErrorHandle(response: res, context: context, onSuccess: () {});
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return users;
  }

  Future<void> createTeam({
    required BuildContext context,
    required String name,
    required String topic,
    required String description,
    required List<String> users,
    required String clubId,
  }) async {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    Map<String,dynamic>body={
      'name':name,
      'topic':topic,
      'description':description,
      'users':users,
      'clubId':clubId
    };

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/create-team'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'x-auth-token': userProvider.user.token,
        },
        body:  jsonEncode(body)
      );
      // print(res.body);
      showSnackBar(context, 'Successfully Created a Team');
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Team>> fetchTeams({
    required BuildContext context,
    required String clubId,
  }) async {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Team> teams = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/teams/$clubId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      print(res.body);
      List<dynamic> decodedJson = jsonDecode(res.body);
      teams = decodedJson.map((unit) => Team.fromMap(unit as Map<String, dynamic>)).toList();
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return teams;
  }
 Future<List<Team>> fetchTeamsForMemberss({
    required BuildContext context,
    required String clubId,
  }) async {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Team> teams = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/teams-for-member/$clubId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      print(res.body);
      List<dynamic> decodedJson = jsonDecode(res.body);
      teams = decodedJson.map((unit) => Team.fromMap(unit as Map<String, dynamic>)).toList();
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return teams;
  }
}

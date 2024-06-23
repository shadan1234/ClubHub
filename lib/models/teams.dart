// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:clubhub/models/user.dart';

class Team {
  final String id;

  final String name;
  final String topic;
  final String description;
  final List<User> users;
  final String clubId;
  final DateTime createdAt;

  Team({required this.id, required this.name, required this.topic, required this.description, required this.users, required this.clubId, required this.createdAt});



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'name': name,
      'topic': topic,
      'description': description,
      'users': users.map((x) => x.toMap()).toList(),
      'clubId': clubId,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Team.fromMap(Map<String, dynamic> map) {
    return Team(
      id: map['_id'] as String,
      name: map['name'] as String,
      topic: map['topic'] as String,
      description: map['description'] as String,
      users: List<User>.from((map['users'] as List<dynamic>).map<User>((x) => User.fromMap(x as Map<String,dynamic>),),),
      clubId: map['clubId'] as String,
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Team.fromJson(String source) => Team.fromMap(json.decode(source) as Map<String, dynamic>);
}

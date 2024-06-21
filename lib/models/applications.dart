// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Application {
  final String id;
  final String userId;
  final String clubId;
  String status; 
  final DateTime appliedAt;
  final String name;

  Application( {
    required this.id,
    required this.userId,
    required this.clubId,
    required this.status,
    required this.appliedAt,
    required this.name
  });



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'clubId': clubId,
      'status': status,
      'appliedAt': appliedAt.toIso8601String(),
      'name':name
    };
  }

  factory Application.fromMap(Map<String, dynamic> map) {
    return Application(
      id: map['_id'] as String,
      userId: map['userId'] as String,
      clubId: map['clubId'] as String,
      status: map['status'] as String,
      appliedAt: DateTime.parse(map['appliedAt']),
      name: map['name'] as String
    );
  }

  String toJson() => json.encode(toMap());

  factory Application.fromJson(String source) => Application.fromMap(json.decode(source) as Map<String, dynamic>);

}

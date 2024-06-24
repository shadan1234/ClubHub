// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Message {
  final String id;
  final String message;
  final String senderId;
  final String clubId;
  final DateTime createdAt;
  final String name;

  Message({required this.id, required this.message, required this.senderId, required this.clubId, required this.createdAt, required this.name});


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'message': message,
      'senderId': senderId,
      'clubId': clubId,
      'createdAt': createdAt.toIso8601String(),
      'name': name,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['_id'] as String,
      message: map['message'] as String,
      senderId: map['senderId'] as String,
      clubId: map['clubId'] as String,
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toString()),
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) => Message.fromMap(json.decode(source) as Map<String, dynamic>);
}

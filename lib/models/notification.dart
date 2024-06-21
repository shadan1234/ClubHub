import 'dart:convert';

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String recipientType;
  final String clubId;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.recipientType,
    required this.clubId,
    required this.createdAt,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['_id'] ?? '',
      title: map['title'] ?? '',
      message: map['message'] ?? '',
      recipientType: map['recipientType'] ?? '',
      clubId: map['clubId'] ?? '',
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'title': title,
      'message': message,
      'recipientType': recipientType,
      'clubId': clubId,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source));
}

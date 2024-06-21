import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String type;
  final String token;
  final String image;
  final String clubOwned;
  final List<String> clubs;
  final String fcmToken;

  User( {
    required this.id,
    required this.name,
    required this.password,
    required this.type,
    required this.token,
    required this.email,
    required this.image,
    required this.clubOwned,
    required this.clubs,
    required this.fcmToken
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'type': type,
      'token': token,
      'image': image,
      'clubOwned': clubOwned,
      'clubs': clubs,
      'fcmToken':fcmToken
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      type: map['type'] ?? '',
      token: map['token'] ?? '',
      image: map['image'] ?? '',
      clubOwned: map['clubOwned'] ?? '',
      clubs: List<String>.from(map['clubs'] ?? []),
      fcmToken: map['fcmToken'] ?? ''
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source));

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? type,
    String? token,
    String? image,
    String? clubOwned,
    List<String>? clubs,
    String? fcmToken
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      type: type ?? this.type,
      token: token ?? this.token,
      image: image ?? this.image,
      clubOwned: clubOwned ?? this.clubOwned,
      clubs: clubs ?? this.clubs,
      fcmToken: fcmToken?? this.fcmToken
    );
  }
}

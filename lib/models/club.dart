import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Club {
  final String id;
 final String image;
 final String nameOfClub;
 final String type;
 final String description;
 final String workDoneByClub;

  Club({
    required this.id,
    required this.image, required this.nameOfClub, required this.type, required this.description, required this.workDoneByClub});
  

 
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id':id,
      'image': image,
      'nameOfClub': nameOfClub,
      'type': type,
      'description': description,
      'workDoneByClub': workDoneByClub,
    };
  }

  factory Club.fromMap(Map<String, dynamic> map) {
    return Club(
      id: map['_id'] as String,
      image: map['image'] as String,
      nameOfClub: map['nameOfClub'] as String,
      type: map['type'] as String,
      description: map['description'] as String,
      workDoneByClub: map['workDoneByClub'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Club.fromJson(String source) => Club.fromMap(json.decode(source) as Map<String, dynamic>);

  Club copyWith({
    String? image,
    String? nameOfClub,
    String? type,
    String? description,
    String? workDoneByClub,
    String? id
  }) {
    return Club(
      id: id?? this.id,
      image: image ?? this.image,
      nameOfClub: nameOfClub ?? this.nameOfClub,
      type: type ?? this.type,
      description: description ?? this.description,
      workDoneByClub: workDoneByClub ?? this.workDoneByClub,
    );
  }
}

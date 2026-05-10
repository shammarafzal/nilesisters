// To parse this JSON data, do
//
//     final getAbout = getAboutFromJson(jsonString);

import 'dart:convert';

GetAbout getAboutFromJson(String str) => GetAbout.fromJson(json.decode(str));

String getAboutToJson(GetAbout data) => json.encode(data.toJson());

class GetAbout {
  GetAbout({
    required this.status,
    required this.data,
  });

  final bool status;
  final Data data;

  factory GetAbout.fromJson(Map<String, dynamic> json) => GetAbout(
    status: json["status"] as bool,
    data: Data.fromJson(json["data"] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.id,
    required this.image,
    required this.description,
    required this.mission,
    required this.history,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String image;
  final String description;
  final String mission;
  final String history;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] as int,
    image: json["image"] as String,
    description: json["description"] as String,
    mission: json["mission"] as String,
    history: json["history"] as String,
    createdAt: DateTime.parse(json["created_at"] as String),
    updatedAt: DateTime.parse(json["updated_at"] as String),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "description": description,
    "mission": mission,
    "history": history,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

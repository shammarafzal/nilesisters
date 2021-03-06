// To parse this JSON data, do
//
//     final getAbout = getAboutFromJson(jsonString);

import 'dart:convert';

GetAbout getAboutFromJson(String str) => GetAbout.fromJson(json.decode(str));

String getAboutToJson(GetAbout data) => json.encode(data.toJson());

class GetAbout {
  GetAbout({
    this.status,
    this.data,
  });

  bool status;
  Data data;

  factory GetAbout.fromJson(Map<String, dynamic> json) => GetAbout(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.image,
    this.description,
    this.mission,
    this.history,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String image;
  String description;
  String mission;
  String history;
  DateTime createdAt;
  DateTime updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    image: json["image"],
    description: json["description"],
    mission: json["mission"],
    history: json["history"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
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

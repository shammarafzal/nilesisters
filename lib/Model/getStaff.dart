// To parse this JSON data, do
//
//     final getStaff = getStaffFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetStaff getStaffFromJson(String str) => GetStaff.fromJson(json.decode(str));

String getStaffToJson(GetStaff data) => json.encode(data.toJson());

class GetStaff {
  GetStaff({
    @required this.status,
    @required this.data,
  });

  bool status;
  List<Datum> data;

  factory GetStaff.fromJson(Map<String, dynamic> json) => GetStaff(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    @required this.id,
    @required this.name,
    @required this.designation,
    @required this.bio,
    @required this.image,
    @required this.createdAt,
    @required this.updatedAt,
  });

  int id;
  String name;
  String designation;
  String bio;
  String image;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    designation: json["designation"],
    bio: json["bio"],
    image: json["image"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "designation": designation,
    "bio": bio,
    "image": image,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

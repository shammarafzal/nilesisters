// To parse this JSON data, do
//
//     final getStaff = getStaffFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetStaff getStaffFromJson(String str) => GetStaff.fromJson(json.decode(str));

String getStaffToJson(GetStaff data) => json.encode(data.toJson());

class GetStaff {
  GetStaff({
    required this.status,
    required this.data,
  });

  final bool status;
  final List<Datum> data;

  factory GetStaff.fromJson(Map<String, dynamic> json) => GetStaff(
    status: json["status"] as bool,
    data: List<Datum>.from((json["data"] as List<dynamic>).map((x) => Datum.fromJson(x as Map<String, dynamic>))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.designation,
    required this.bio,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String name;
  final String designation;
  final String bio;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] as int,
    name: json["name"] as String,
    designation: json["designation"] as String,
    bio: json["bio"] as String,
    image: json["image"] as String,
    createdAt: DateTime.parse(json["created_at"] as String),
    updatedAt: DateTime.parse(json["updated_at"] as String),
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

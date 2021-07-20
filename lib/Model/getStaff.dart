// To parse this JSON data, do
//
//     final getStaff = getStaffFromJson(jsonString);

import 'dart:convert';

GetStaff getStaffFromJson(String str) => GetStaff.fromJson(json.decode(str));

String getStaffToJson(GetStaff data) => json.encode(data.toJson());

class GetStaff {
  GetStaff({
    this.status,
    this.data,
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
    this.id,
    this.name,
    this.education,
    this.designation,
    this.image,
    this.age,
    this.country,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String education;
  String designation;
  String image;
  String age;
  String country;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    education: json["education"],
    designation: json["designation"],
    image: json["image"],
    age: json["age"],
    country: json["country"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "education": education,
    "designation": designation,
    "image": image,
    "age": age,
    "country": country,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

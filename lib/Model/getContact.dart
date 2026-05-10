// To parse this JSON data, do
//
//     final getContact = getContactFromJson(jsonString);

import 'dart:convert';

GetContact getContactFromJson(String str) => GetContact.fromJson(json.decode(str));

String getContactToJson(GetContact data) => json.encode(data.toJson());

class GetContact {
  GetContact({
    required this.status,
    required this.data,
  });

  final bool status;
  final List<Datum> data;

  factory GetContact.fromJson(Map<String, dynamic> json) => GetContact(
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
    required this.officeName,
    required this.address,
    required this.englishPhone,
    required this.spanishPhone,
    required this.email,
    required this.facebookPage1,
    required this.facebookPage2,
    required this.instagramPage1,
    required this.instagramPage2,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String officeName;
  final String address;
  final String englishPhone;
  final String spanishPhone;
  final String email;
  final String facebookPage1;
  final String facebookPage2;
  final String instagramPage1;
  final String instagramPage2;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] as int,
    officeName: json["office_name"] as String,
    address: json["address"] as String,
    englishPhone: json["english_phone"] as String,
    spanishPhone: json["spanish_phone"] as String,
    email: json["email"] as String,
    facebookPage1: json["facebook_page_1"] as String,
    facebookPage2: json["facebook_page_2"] as String,
    instagramPage1: json["instagram_page_1"] as String,
    instagramPage2: json["instagram_page_2"] as String,
    createdAt: DateTime.parse(json["created_at"] as String),
    updatedAt: DateTime.parse(json["updated_at"] as String),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "office_name": officeName,
    "address": address,
    "english_phone": englishPhone,
    "spanish_phone": spanishPhone,
    "email": email,
    "facebook_page_1": facebookPage1,
    "facebook_page_2": facebookPage2,
    "instagram_page_1": instagramPage1,
    "instagram_page_2": instagramPage2,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

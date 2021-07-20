// To parse this JSON data, do
//
//     final getContact = getContactFromJson(jsonString);

import 'dart:convert';

GetContact getContactFromJson(String str) => GetContact.fromJson(json.decode(str));

String getContactToJson(GetContact data) => json.encode(data.toJson());

class GetContact {
  GetContact({
    this.status,
    this.data,
  });

  bool status;
  List<Datum> data;

  factory GetContact.fromJson(Map<String, dynamic> json) => GetContact(
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
    this.officeName,
    this.address,
    this.englishPhone,
    this.spanishPhone,
    this.email,
    this.facebookPage1,
    this.facebookPage2,
    this.instagramPage1,
    this.instagramPage2,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String officeName;
  String address;
  String englishPhone;
  String spanishPhone;
  String email;
  String facebookPage1;
  String facebookPage2;
  String instagramPage1;
  String instagramPage2;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    officeName: json["office_name"],
    address: json["address"],
    englishPhone: json["english_phone"],
    spanishPhone: json["spanish_phone"],
    email: json["email"],
    facebookPage1: json["facebook_page_1"],
    facebookPage2: json["facebook_page_2"],
    instagramPage1: json["instagram_page_1"],
    instagramPage2: json["instagram_page_2"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
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

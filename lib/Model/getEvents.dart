// To parse this JSON data, do
//
//     final getEvents = getEventsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetEvents getEventsFromJson(String str) => GetEvents.fromJson(json.decode(str));

String getEventsToJson(GetEvents data) => json.encode(data.toJson());

class GetEvents {
  GetEvents({
    @required this.status,
    @required this.data,
  });

  bool status;
  List<Datum> data;

  factory GetEvents.fromJson(Map<String, dynamic> json) => GetEvents(
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
    @required this.title,
    @required this.date,
    @required this.time,
    @required this.location,
    @required this.fee,
    @required this.benefits,
    @required this.details,
    @required this.file,
    @required this.addressLatitude,
    @required this.addressLongitude,
    @required this.createdAt,
    @required this.updatedAt,
  });

  int id;
  String title;
  String date;
  String time;
  String location;
  String fee;
  String benefits;
  String details;
  String file;
  String addressLatitude;
  String addressLongitude;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    date: json["date"],
    time: json["time"],
    location: json["location"],
    fee: json["fee"],
    benefits: json["benefits"],
    details: json["details"],
    file: json["file"],
    addressLatitude: json["address_latitude"],
    addressLongitude: json["address_longitude"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "date": date,
    "time": time,
    "location": location,
    "fee": fee,
    "benefits": benefits,
    "details": details,
    "file": file,
    "address_latitude": addressLatitude,
    "address_longitude": addressLongitude,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

// To parse this JSON data, do
//
//     final getEvents = getEventsFromJson(jsonString);

import 'dart:convert';

GetEvents getEventsFromJson(String str) => GetEvents.fromJson(json.decode(str));

String getEventsToJson(GetEvents data) => json.encode(data.toJson());

class GetEvents {
  GetEvents({
    this.status,
    this.data,
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
    this.id,
    this.title,
    this.date,
    this.time,
    this.location,
    this.fee,
    this.benefits,
    this.details,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String title;
  String date;
  String time;
  String location;
  String fee;
  String benefits;
  String details;
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
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

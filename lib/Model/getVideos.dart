// To parse this JSON data, do
//
//     final getVideos = getVideosFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetVideos getVideosFromJson(String str) => GetVideos.fromJson(json.decode(str));

String getVideosToJson(GetVideos data) => json.encode(data.toJson());

class GetVideos {
  GetVideos({
    @required this.status,
    @required this.data,
  });

  bool status;
  List<Datum> data;

  factory GetVideos.fromJson(Map<String, dynamic> json) => GetVideos(
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
    @required this.link,
    @required this.createdAt,
    @required this.updatedAt,
  });

  int id;
  String title;
  String link;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    link: json["link"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "link": link,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

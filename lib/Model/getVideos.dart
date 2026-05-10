// To parse this JSON data, do
//
//     final getVideos = getVideosFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetVideos getVideosFromJson(String str) => GetVideos.fromJson(json.decode(str));

String getVideosToJson(GetVideos data) => json.encode(data.toJson());

class GetVideos {
  GetVideos({
    required this.status,
    required this.data,
  });

  final bool status;
  final List<Datum> data;

  factory GetVideos.fromJson(Map<String, dynamic> json) => GetVideos(
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
    required this.title,
    required this.link,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String title;
  final String link;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] as int,
    title: json["title"] as String,
    link: json["link"] as String,
    createdAt: DateTime.parse(json["created_at"] as String),
    updatedAt: DateTime.parse(json["updated_at"] as String),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "link": link,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

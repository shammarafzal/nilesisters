// To parse this JSON data, do
//
//     final getVideos = getVideosFromJson(jsonString);

import 'dart:convert';

GetVideos getVideosFromJson(String str) => GetVideos.fromJson(json.decode(str));

String getVideosToJson(GetVideos data) => json.encode(data.toJson());

class GetVideos {
  GetVideos({
    this.status,
    this.data,
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
    this.id,
    this.title,
    this.file,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String title;
  String file;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    file: json["file"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "file": file,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

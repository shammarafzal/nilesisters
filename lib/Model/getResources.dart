// To parse this JSON data, do
//
//     final getResources = getResourcesFromJson(jsonString);

import 'dart:convert';

GetResources getResourcesFromJson(String str) => GetResources.fromJson(json.decode(str));

String getResourcesToJson(GetResources data) => json.encode(data.toJson());

class GetResources {
  GetResources({
    this.status,
    this.data,
  });

  bool status;
  List<Datum> data;

  factory GetResources.fromJson(Map<String, dynamic> json) => GetResources(
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
    this.edition,
    this.context,
    this.format,
    this.totalPages,
    this.file,
    this.icon,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String title;
  String edition;
  String context;
  String format;
  String totalPages;
  String file;
  String icon;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    edition: json["edition"],
    context: json["context"],
    format: json["format"],
    totalPages: json["total_pages"],
    file: json["file"],
    icon: json["icon"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "edition": edition,
    "context": context,
    "format": format,
    "total_pages": totalPages,
    "file": file,
    "icon": icon,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

// To parse this JSON data, do
//
//     final getResources = getResourcesFromJson(jsonString);

import 'dart:convert';

GetResources getResourcesFromJson(String str) => GetResources.fromJson(json.decode(str));

String getResourcesToJson(GetResources data) => json.encode(data.toJson());

class GetResources {
  GetResources({
    required this.status,
    required this.data,
  });

  final bool status;
  final List<Datum> data;

  factory GetResources.fromJson(Map<String, dynamic> json) => GetResources(
    status: json["status"].toString().toLowerCase() == 'true' || json["status"] == 1 || json["status"] == true,
    data: json["data"] == null 
      ? [] 
      : List<Datum>.from((json["data"] as List<dynamic>).map((x) => Datum.fromJson(x as Map<String, dynamic>))),
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
    required this.edition,
    required this.context,
    required this.format,
    required this.totalPages,
    required this.file,
    required this.icon,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String title;
  final String edition;
  final String context;
  final String format;
  final String totalPages;
  final String file;
  final String icon;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] is int ? json["id"] as int : int.tryParse(json["id"].toString()) ?? 0,
    title: json["title"]?.toString() ?? '',
    edition: json["edition"]?.toString() ?? '',
    context: json["context"]?.toString() ?? '',
    format: json["format"]?.toString() ?? '',
    totalPages: json["total_pages"]?.toString() ?? '0',
    file: json["file"]?.toString() ?? '',
    icon: json["icon"]?.toString() ?? '',
    createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"].toString()) : DateTime.now(),
    updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"].toString()) : DateTime.now(),
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

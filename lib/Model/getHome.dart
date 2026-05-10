// To parse this JSON data, do
//
//     final getHome = getHomeFromJson(jsonString);

import 'dart:convert';

GetHome getHomeFromJson(String str) => GetHome.fromJson(json.decode(str));

String getHomeToJson(GetHome data) => json.encode(data.toJson());

class GetHome {
  GetHome({
    required this.status,
    required this.data,
  });

  final bool status;
  final List<Datum> data;

  factory GetHome.fromJson(Map<String, dynamic> json) => GetHome(
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
    required this.image,
    required this.description,
    required this.category,
    required this.newsLink,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String title;
  final String image;
  final String description;
  final String category;
  final String newsLink;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] as int,
    title: json["title"] as String,
    image: json["image"] as String,
    description: json["description"] as String,
    category: json["category"] as String,
    newsLink: json["news_link"] as String,
    createdAt: DateTime.parse(json["created_at"] as String),
    updatedAt: DateTime.parse(json["updated_at"] as String),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
    "description": description,
    "category": category,
    "news_link": newsLink,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

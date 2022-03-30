// To parse this JSON data, do
//
//     final getHome = getHomeFromJson(jsonString);

import 'dart:convert';

GetHome getHomeFromJson(String str) => GetHome.fromJson(json.decode(str));

String getHomeToJson(GetHome data) => json.encode(data.toJson());

class GetHome {
  GetHome({
    this.status,
    this.data,
  });

  bool status;
  List<Datum> data;

  factory GetHome.fromJson(Map<String, dynamic> json) => GetHome(
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
    this.image,
    this.description,
    this.category,
    this.newsLink,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String title;
  String image;
  String description;
  String category;
  String newsLink;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    image: json["image"],
    description: json["description"],
    category: json["category"],
    newsLink: json["news_link"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
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

// To parse this JSON data, do
//
//     final getHomePage = getHomePageFromMap(jsonString);

import 'dart:convert';

List<GetHomePage> getHomePageFromMap(String str) => List<GetHomePage>.from(json.decode(str).map((x) => GetHomePage.fromMap(x)));

String getHomePageToMap(List<GetHomePage> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class GetHomePage {
  GetHomePage({
    this.id,
    this.news,
    this.image,
  });

  String id;
  String news;
  String image;

  factory GetHomePage.fromMap(Map<String, dynamic> json) => GetHomePage(
    id: json["id"],
    news: json["news"],
    image: json["image"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "news": news,
    "image": image,
  };
}

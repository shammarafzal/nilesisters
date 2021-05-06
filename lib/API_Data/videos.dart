// To parse this JSON data, do
//
//     final getVideos = getVideosFromJson(jsonString);

import 'dart:convert';

List<GetVideos> getVideosFromJson(String str) => List<GetVideos>.from(json.decode(str).map((x) => GetVideos.fromJson(x)));

String getVideosToJson(List<GetVideos> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetVideos {
  GetVideos({
    this.id,
    this.videotitle,
    this.videourl,
  });

  String id;
  String videotitle;
  String videourl;

  factory GetVideos.fromJson(Map<String, dynamic> json) => GetVideos(
    id: json["id"],
    videotitle: json["videotitle"],
    videourl: json["videourl"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "videotitle": videotitle,
    "videourl": videourl,
  };
}

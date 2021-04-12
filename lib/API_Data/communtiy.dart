// To parse this JSON data, do
//
//     final community = communityFromMap(jsonString);

import 'dart:convert';

List<Community> communityFromMap(String str) => List<Community>.from(json.decode(str).map((x) => Community.fromMap(x)));

String communityToMap(List<Community> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Community {
  Community({
    this.postid,
    this.posttext,
    this.timess,
    this.userid,
    this.userimage,
    this.username,
  });

  String postid;
  String posttext;
  String timess;
  String userid;
  String userimage;
  String username;

  factory Community.fromMap(Map<String, dynamic> json) => Community(
    postid: json["postid"],
    posttext: json["posttext"],
    timess: json["timess"],
    userid: json["userid"],
    userimage: json["userimage"],
    username: json["username"],
  );

  Map<String, dynamic> toMap() => {
    "postid": postid,
    "posttext": posttext,
    "timess": timess,
    "userid": userid,
    "userimage": userimage,
    "username": username,
  };
}

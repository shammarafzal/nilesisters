// To parse this JSON data, do
//
//     final getPosts = getPostsFromJson(jsonString);

import 'dart:convert';

List<GetPosts> getPostsFromJson(String str) => List<GetPosts>.from(json.decode(str).map((x) => GetPosts.fromJson(x)));

String getPostsToJson(List<GetPosts> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetPosts {
  GetPosts({
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

  factory GetPosts.fromJson(Map<String, dynamic> json) => GetPosts(
    postid: json["postid"],
    posttext: json["posttext"],
    timess: json["timess"],
    userid: json["userid"],
    userimage: json["userimage"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "postid": postid,
    "posttext": posttext,
    "timess": timess,
    "userid": userid,
    "userimage": userimage,
    "username": username,
  };
}

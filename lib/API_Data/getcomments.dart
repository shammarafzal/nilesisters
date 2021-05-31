// To parse this JSON data, do
//
//     final getPosts = getPostsFromJson(jsonString);

import 'dart:convert';

List<GetComments> getCommentsFromJson(String str) => List<GetComments>.from(json.decode(str).map((x) => GetComments.fromJson(x)));

String getCommentsToJson(List<GetComments> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetComments {
  GetComments({
    this.commentid,
    this.postid,
    this.userid,
    this.comenttext,
    this.commenttime,
    this.username,
  });

  String commentid;
  String postid;
  String userid;
  String comenttext;
  String commenttime;
  String username;

  factory GetComments.fromJson(Map<String, dynamic> json) => GetComments(
    commentid: json["commentid"],
    postid: json["postid"],
    userid: json["userid"],
    comenttext: json["comenttext"],
    commenttime: json["commenttime"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "commentid": commentid,
    "postid": postid,
    "userid": userid,
    "comenttext": comenttext,
    "commenttime": commenttime,
    "username": username,
  };
}

// To parse this JSON data, do
//
//     final getPosts = getPostsFromJson(jsonString);

import 'dart:convert';

GetPosts getPostsFromJson(String str) => GetPosts.fromJson(json.decode(str));

String getPostsToJson(GetPosts data) => json.encode(data.toJson());

class GetPosts {
  GetPosts({
    this.status,
    this.data,
    this.user,
  });

  bool status;
  List<Datum> data;
  User user;

  factory GetPosts.fromJson(Map<String, dynamic> json) => GetPosts(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "user": user.toJson(),
  };
}

class Datum {
  Datum({
    this.id,
    this.post,
    this.isApproved,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String post;
  String isApproved;
  String userId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    post: json["post"],
    isApproved: json["is_approved"],
    userId: json["user_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "post": post,
    "is_approved": isApproved,
    "user_id": userId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.isAdmin,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String email;
  dynamic phone;
  dynamic image;
  String isAdmin;
  DateTime createdAt;
  DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    image: json["image"],
    isAdmin: json["is_admin"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "image": image,
    "is_admin": isAdmin,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

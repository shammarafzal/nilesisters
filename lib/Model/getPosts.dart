// To parse this JSON data, do
//
//     final getPosts = getPostsFromJson(jsonString);

import 'dart:convert';

GetPosts getPostsFromJson(String str) => GetPosts.fromJson(json.decode(str));

String getPostsToJson(GetPosts data) => json.encode(data.toJson());

class GetPosts {
  GetPosts({
    required this.status,
    required this.data,
  });

  final bool status;
  final List<Datum> data;

  factory GetPosts.fromJson(Map<String, dynamic> json) => GetPosts(
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
    required this.post,
    required this.isApproved,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  final int id;
  final String post;
  final String isApproved;
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User user;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] as int,
    post: json["post"] as String,
    isApproved: json["is_approved"] as String,
    userId: json["user_id"] as String,
    createdAt: DateTime.parse(json["created_at"] as String),
    updatedAt: DateTime.parse(json["updated_at"] as String),
    user: User.fromJson(json["user"] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "post": post,
    "is_approved": isApproved,
    "user_id": userId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "user": user.toJson(),
  };
}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.isAdmin,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String name;
  final String email;
  final dynamic phone;
  final dynamic image;
  final String isAdmin;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] as int,
    name: json["name"] as String,
    email: json["email"] as String,
    phone: json["phone"],
    image: json["image"],
    isAdmin: json["is_admin"] as String,
    createdAt: DateTime.parse(json["created_at"] as String),
    updatedAt: DateTime.parse(json["updated_at"] as String),
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

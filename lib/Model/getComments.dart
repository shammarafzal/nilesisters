// To parse this JSON data, do
//
//     final getComments = getCommentsFromJson(jsonString);

import 'dart:convert';

GetComments getCommentsFromJson(String str) => GetComments.fromJson(json.decode(str));

String getCommentsToJson(GetComments data) => json.encode(data.toJson());

class GetComments {
  GetComments({
    required this.status,
    required this.data,
  });

  final bool status;
  final List<Datum> data;

  factory GetComments.fromJson(Map<String, dynamic> json) => GetComments(
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
    required this.comment,
    required this.postId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  final int id;
  final String comment;
  final String postId;
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User user;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] as int,
    comment: json["comment"] as String,
    postId: json["post_id"] as String,
    userId: json["user_id"] as String,
    createdAt: DateTime.parse(json["created_at"] as String),
    updatedAt: DateTime.parse(json["updated_at"] as String),
    user: User.fromJson(json["user"] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "comment": comment,
    "post_id": postId,
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

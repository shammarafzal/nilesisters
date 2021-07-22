// To parse this JSON data, do
//
//     final getComments = getCommentsFromJson(jsonString);

import 'dart:convert';

GetComments getCommentsFromJson(String str) => GetComments.fromJson(json.decode(str));

String getCommentsToJson(GetComments data) => json.encode(data.toJson());

class GetComments {
  GetComments({
    this.status,
    this.data,
  });

  bool status;
  List<Datum> data;

  factory GetComments.fromJson(Map<String, dynamic> json) => GetComments(
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
    this.comment,
    this.postId,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  int id;
  String comment;
  String postId;
  String userId;
  DateTime createdAt;
  DateTime updatedAt;
  User user;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    comment: json["comment"],
    postId: json["post_id"],
    userId: json["user_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    user: User.fromJson(json["user"]),
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


import 'dart:convert';

List<Staff> staffFromMap(String str) => List<Staff>.from(json.decode(str).map((x) => Staff.fromMap(x)));

String staffToMap(List<Staff> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Staff {
  Staff({
    this.id,
    this.name,
    this.education,
    this.designation,
    this.staffimf,
  });

  String id;
  String name;
  String education;
  String designation;
  String staffimf;

  factory Staff.fromMap(Map<String, dynamic> json) => Staff(
    id: json["id"],
    name: json["name"],
    education: json["education"],
    designation: json["designation"],
    staffimf: json["staffimf"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "education": education,
    "designation": designation,
    "staffimf": staffimf,
  };
}

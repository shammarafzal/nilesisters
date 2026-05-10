import 'dart:convert';

GetEvents getEventsFromJson(String str) => GetEvents.fromJson(json.decode(str));

String getEventsToJson(GetEvents data) => json.encode(data.toJson());

class GetEvents {
  GetEvents({
    required this.status,
    required this.data,
  });

  final bool status;
  final List<Datum> data;

  factory GetEvents.fromJson(Map<String, dynamic> json) => GetEvents(
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
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.fee,
    required this.benefits,
    required this.details,
    required this.file,
    required this.addressLatitude,
    required this.addressLongitude,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String title;
  final String date;
  final String time;
  final String location;
  final String fee;
  final String benefits;
  final String details;
  final String file;
  final String addressLatitude;
  final String addressLongitude;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] as int,
    title: json["title"] as String,
    date: json["date"] as String,
    time: json["time"] as String,
    location: json["location"] as String,
    fee: json["fee"] as String,
    benefits: json["benefits"] as String,
    details: json["details"] as String,
    file: json["file"] as String,
    addressLatitude: json["address_latitude"] as String,
    addressLongitude: json["address_longitude"] as String,
    createdAt: DateTime.parse(json["created_at"] as String),
    updatedAt: DateTime.parse(json["updated_at"] as String),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "date": date,
    "time": time,
    "location": location,
    "fee": fee,
    "benefits": benefits,
    "details": details,
    "file": file,
    "address_latitude": addressLatitude,
    "address_longitude": addressLongitude,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

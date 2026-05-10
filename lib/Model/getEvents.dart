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
    status: json["status"].toString().toLowerCase() == 'true' || json["status"] == 1 || json["status"] == true,
    data: json["data"] == null 
      ? [] 
      : List<Datum>.from((json["data"] as List<dynamic>).map((x) => Datum.fromJson(x as Map<String, dynamic>))),
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
    id: json["id"] is int ? json["id"] as int : int.tryParse(json["id"].toString()) ?? 0,
    title: json["title"]?.toString() ?? '',
    date: json["date"]?.toString() ?? '',
    time: json["time"]?.toString() ?? '',
    location: json["location"]?.toString() ?? '',
    fee: json["fee"]?.toString() ?? '',
    benefits: json["benefits"]?.toString() ?? '',
    details: json["details"]?.toString() ?? '',
    file: json["file"]?.toString() ?? '',
    addressLatitude: json["address_latitude"]?.toString() ?? '0.0',
    addressLongitude: json["address_longitude"]?.toString() ?? '0.0',
    createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"].toString()) : DateTime.now(),
    updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"].toString()) : DateTime.now(),
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

// To parse this JSON data, do
//
//     final eventss = eventssFromMap(jsonString);

import 'dart:convert';

List<Eventss> eventssFromMap(String str) => List<Eventss>.from(json.decode(str).map((x) => Eventss.fromMap(x)));

String eventssToMap(List<Eventss> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Eventss {
  Eventss({
    this.id,
    this.title,
    this.day,
    this.fee,
    this.benifits,
    this.dates,
    this.starttime,
    this.endtime,
    this.location,
    this.lat,
    this.log,
    this.detail,
  });

  String id;
  String title;
  String day;
  String fee;
  String benifits;
  DateTime dates;
  String starttime;
  String endtime;
  String location;
  String lat;
  String log;
  String detail;

  factory Eventss.fromMap(Map<String, dynamic> json) => Eventss(
    id: json["id"],
    title: json["title"],
    day: json["day"],
    fee: json["fee"],
    benifits: json["benifits"],
    dates: DateTime.parse(json["dates"]),
    starttime: json["starttime"],
    endtime: json["endtime"],
    location: json["location"],
    lat: json["lat"],
    log: json["log"],
    detail: json["detail"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "day": day,
    "fee": fee,
    "benifits": benifits,
    "dates": "${dates.year.toString().padLeft(4, '0')}-${dates.month.toString().padLeft(2, '0')}-${dates.day.toString().padLeft(2, '0')}",
    "starttime": starttime,
    "endtime": endtime,
    "location": location,
    "lat": lat,
    "log": log,
    "detail": detail,
  };
}

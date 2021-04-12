
import 'dart:convert';

List<Pdf> pdfFromMap(String str) => List<Pdf>.from(json.decode(str).map((x) => Pdf.fromMap(x)));

String pdfToMap(List<Pdf> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Pdf {
  Pdf({
    this.id,
    this.title,
    this.contect,
    this.edition,
    this.format,
    this.pagesize,
    this.pagecount,
    this.pdfurl,
    this.pdfimage,
  });

  String id;
  String title;
  String contect;
  String edition;
  String format;
  String pagesize;
  String pagecount;
  String pdfurl;
  String pdfimage;

  factory Pdf.fromMap(Map<String, dynamic> json) => Pdf(
    id: json["id"],
    title: json["title"],
    contect: json["contect"],
    edition: json["edition"],
    format: json["format"],
    pagesize: json["pagesize"],
    pagecount: json["pagecount"],
    pdfurl: json["pdfurl"],
    pdfimage: json["pdfimage"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "contect": contect,
    "edition": edition,
    "format": format,
    "pagesize": pagesize,
    "pagecount": pagecount,
    "pdfurl": pdfurl,
    "pdfimage": pdfimage,
  };
}

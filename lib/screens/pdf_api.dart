import 'dart:convert';

import 'package:nilesisters/API_Data/getHome.dart';
import 'package:nilesisters/API_Data/pdf.dart';
import 'package:http/http.dart' as http;
Future<List<Pdf>> fetchPdfs() async {
  var url = Uri.https('nilesisters.codingoverflow.com', '/api/getpdf.php', {"q": "dart"});
  final response = await http.get(url);
  return pdfFromMap(response.body);
}
Future<List<GetHomePage>> fetchHome() async {
  var url = Uri.http('nilesisters.codingoverflow.com', '/api/gethomepage.php', {"q": "dart"});
  final response = await http.get(url);
  return getHomePageFromMap(response.body);
}

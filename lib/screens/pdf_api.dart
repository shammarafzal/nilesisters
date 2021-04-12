import 'package:nilesisters/API_Data/pdf.dart';
import 'package:http/http.dart' as http;
Future<List<Pdf>> fetchPdfs() async {
  var url = Uri.http('localhost:8888', '/public_html/getpdf.php', {"q": "dart"});
  final response = await http.get(url);
  return pdfFromMap(response.body);
}
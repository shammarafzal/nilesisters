import 'package:nilesisters/API_Data/pdf.dart';
import 'package:http/http.dart' as http;
import 'package:nilesisters/API_Data/staff.dart';
Future<List<Staff>> fetchStaff() async {
  var url = Uri.https('nilesisters.codingoverflow.com', '/api/getstafdata.php', {"q": "dart"});
  final response = await http.get(url);
  return staffFromMap(response.body);
}
import 'package:nilesisters/API_Data/communtiy.dart';
import 'package:http/http.dart' as http;
Future<List<Community>> fetchcommunity() async {
  var url = Uri.http('http://localhost:8888', '/public_html/getposts.php', {"q": "dart"});
  final response = await http.get(url);
  return communityFromMap(response.body);
}
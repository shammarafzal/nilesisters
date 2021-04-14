import 'package:nilesisters/API_Data/communtiy.dart';
import 'package:http/http.dart' as http;
Future<List<Community>> fetchcommunity() async {
  var url = Uri.https('nilesisters.codingoverflow.com', '/api/getposts.php', {"q": "dart"});
  final response = await http.get(url);
  return communityFromMap(response.body);
}
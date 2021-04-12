import 'package:nilesisters/API_Data/users.dart';
import 'package:http/http.dart' as http;
Future<List<Users>> fetchUsers() async {
  var url = Uri.http('localhost:8888', '/public_html/getusers.php', {"q": "dart"});
  final response = await http.get(url);
  return usersFromJson(response.body);
}
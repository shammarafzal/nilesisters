import 'package:nilesisters/API_Data/users.dart';
import 'package:http/http.dart' as http;
Future<List<Users>> fetchUsers() async {
  var url = Uri.https('nilesisters.codingoverflow.com', '/api/getusers.php', {"q": "dart"});
  final response = await http.get(url);
  return usersFromJson(response.body);
}
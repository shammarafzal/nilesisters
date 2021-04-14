import 'package:nilesisters/API_Data/getpost.dart';
import 'package:http/http.dart' as http;
Future<List<GetPosts>> fetchPosts() async {
  var url = Uri.https('nilesisters.codingoverflow.com', '/api/getposts.php', {"q": "dart"});
  final response = await http.get(url);
  return getPostsFromJson(response.body);
}
import 'package:nilesisters/API_Data/getpost.dart';
import 'package:http/http.dart' as http;
Future<List<GetPosts>> fetchPosts() async {
  var url = Uri.http('localhost:8888', '/public_html/getposts.php', {"q": "dart"});
  final response = await http.get(url);
  return getPostsFromJson(response.body);
}
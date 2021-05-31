import 'package:nilesisters/API_Data/getcomments.dart';
import 'package:nilesisters/API_Data/getpost.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
Future<List<GetPosts>> fetchPosts() async {
  var url = Uri.https('nilesisters.codingoverflow.com', '/api/getposts.php', {"q": "dart"});
  final response = await http.get(url);
  return getPostsFromJson(response.body);
}

Future<List<GetComments>> fetchComments() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  String stringValue = prefs.getString('postid');
  var url = Uri.https('nilesisters.codingoverflow.com', '/api/getcomments.php', {"q": "dart"});
  final response = await http.post(url,
      body: {
        "postid": stringValue,
      });
  return getCommentsFromJson(response.body);
}

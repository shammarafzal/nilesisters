import 'package:nilesisters/API_Data/pdf.dart';
import 'package:http/http.dart' as http;
import 'package:nilesisters/API_Data/videos.dart';
Future<List<GetVideos>> fetchVideos() async {
  var url = Uri.https('nilesisters.codingoverflow.com', '/api/getvideos.php', {"q": "dart"});
  final response = await http.get(url);
  return getVideosFromJson(response.body);
}
import 'package:nilesisters/API_Data/events.dart';
import 'package:http/http.dart' as http;
Future<List<Eventss>> fetchEvents() async {
  var url = Uri.http('localhost:8888', '/public_html/getevents.php', {"q": "dart"});
  final response = await http.get(url);
  return eventssFromMap(response.body);
}
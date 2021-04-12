import 'dart:convert';
import 'package:http/http.dart' as http;
class EventsAPI{

  getEvents() async {
    var url = Uri.http('ocalhost:8888', '/public_html/getevents.php', {"q": "dart"});
    final response = await http.post(url);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      print(responseString);
      return json.decode(responseString);
    }
    else {
      return null;
    }
  }
}

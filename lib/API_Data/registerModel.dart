import 'dart:convert';
import 'package:http/http.dart' as http;


class RegisterModel{

  createUser(String email, String password, String picture,String name, ) async {
    var url = Uri.http('localhost:8888', '/public_html/userregistration.php', {"q": "dart"});
    final response = await http.post(url, body: {
      "email": email,
      "password": password,
      "image": picture,
      "name": name,
    });
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

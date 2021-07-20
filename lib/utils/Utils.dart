import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nilesisters/Model/getAbout.dart';
import 'package:nilesisters/Model/getContact.dart';
import 'package:nilesisters/Model/getEvents.dart';
import 'package:nilesisters/Model/getResources.dart';
import 'package:nilesisters/Model/getStaff.dart';
import 'package:nilesisters/Model/getUser.dart';
import 'package:nilesisters/Model/getVideos.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  final String baseUrl = '127.0.0.1:8000';
  var image_base_url = 'http://127.0.0.1:8000/storage/';
  register(String name, String email, String password,String confirm_password) async {
    var url = Uri.http(baseUrl,
        '/api/register', {"q": "dart"});
    final response = await http.post(url, body: {
      "name": name,
      "email": email,
      "password": password,
      "password_confirmation": confirm_password,
    });
    if (response.statusCode == 200) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    }
    else if (response.statusCode == 500) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    }
    else{
      final String responseString = response.body;
      return jsonDecode(responseString);
    }
  }
  login(String email, String password) async {
    var url = Uri.http(baseUrl,
        '/api/login', {"q": "dart"});
    final response = await http.post(url, body: {
      "email": email,
      "password": password,
    });
    if (response.statusCode == 200) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    }
    else if (response.statusCode == 401) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    }
    else if (response.statusCode == 500) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    }
    else{
      final String responseString = response.body;
      return jsonDecode(responseString);
    }
  }
  forgot(String email) async {
    var url = Uri.http(baseUrl,
        '/api/forgot', {"q": "dart"});
    final response = await http.post(url, body: {
      "email": email,
    });
    if (response.statusCode == 200) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    }
    else if (response.statusCode == 400) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    }
    else if (response.statusCode == 404) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    }
    else if (response.statusCode == 500) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    }
    else{
      final String responseString = response.body;
      return jsonDecode(responseString);
    }
  }
  checkForgotToken(String token) async {
    var url = Uri.http(baseUrl,
        '/api/checkToken', {"q": "dart"});
    final response = await http.post(url, body: {
      "token": token,
    });
    if (response.statusCode == 200) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    }
    else if (response.statusCode == 400) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    }
    else if (response.statusCode == 404) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    }
    else if (response.statusCode == 500) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    }
    else{
      final String responseString = response.body;
      return jsonDecode(responseString);
    }
  }
  resetPassword(String token, String password, String password_confirm) async {
    var url = Uri.http(baseUrl,
        '/api/reset', {"q": "dart"});
    final response = await http.post(url, body: {
      "token": token,
      "password": password,
      "password_confirm": password_confirm
    });
    if (response.statusCode == 200) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    }
    else if (response.statusCode == 400) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    }
    else if (response.statusCode == 404) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    }
    else if (response.statusCode == 500) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    }
    else{
      final String responseString = response.body;
      return jsonDecode(responseString);
    }
  }
  contactUs(String name, String email, String message) async {
    var url = Uri.http(baseUrl,
        '/api/contactus', {"q": "dart"});
    final response = await http.post(url, body: {
      "name": name,
      "email": email,
      "message": message
    });
    if (response.statusCode == 200) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    }
    else if (response.statusCode == 500) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    }
    else{
      final String responseString = response.body;
      return jsonDecode(responseString);
    }
  }
  updateProfile(String name, String phone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getInt('id');
    var token = prefs.getString('token');
    var url = Uri.http(baseUrl,
        '/api/update/$id', {"q": "dart"});
    final response = await http.post(url, body: {
      "name": name,
      "phone": phone,
    },headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    }
    else if (response.statusCode == 500) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    }
    else{
      final String responseString = response.body;
      return jsonDecode(responseString);
    }
  }
  Future<GetResources> fetchResources() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var url = Uri.http(baseUrl, '/api/resources', {"q": "dart"});
    final response = await http.get(url,headers: {
      'Authorization': 'Bearer $token',
    });
    return GetResources.fromJson(jsonDecode(response.body));
  }
  Future<GetEvents> fetchEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var url = Uri.http(baseUrl, '/api/events', {"q": "dart"});
    final response = await http.get(url,headers: {
      'Authorization': 'Bearer $token',
    });
    return GetEvents.fromJson(jsonDecode(response.body));
  }
  Future<GetUser> fetchuser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var url = Uri.http(baseUrl, '/api/user', {"q": "dart"});
    final response = await http.get(url,headers: {
      'Authorization': 'Bearer $token',
    });
    return GetUser.fromJson(jsonDecode(response.body));
  }
  Future<GetAbout> fetchabout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var url = Uri.http(baseUrl, '/api/about', {"q": "dart"});
    final response = await http.get(url,headers: {
      'Authorization': 'Bearer $token',
    });
    return GetAbout.fromJson(jsonDecode(response.body));
  }
  Future<GetStaff> fetchstaff() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var url = Uri.http(baseUrl, '/api/staff', {"q": "dart"});
    final response = await http.get(url,headers: {
      'Authorization': 'Bearer $token',
    });
    return GetStaff.fromJson(jsonDecode(response.body));
  }
  Future<GetVideos> fetchvideos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var url = Uri.http(baseUrl, '/api/videos', {"q": "dart"});
    final response = await http.get(url,headers: {
      'Authorization': 'Bearer $token',
    });
    return GetVideos.fromJson(jsonDecode(response.body));
  }
  Future<GetContact> fetchcontact() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var url = Uri.http(baseUrl, '/api/contact', {"q": "dart"});
    final response = await http.get(url,headers: {
      'Authorization': 'Bearer $token',
    });
    return GetContact.fromJson(jsonDecode(response.body));
  }
}

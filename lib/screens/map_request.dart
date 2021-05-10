import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
const apiKey = "AIzaSyB06U2r80on9ZG0p2OD-6Novl4m0SS7N0A";

class GoogleMapsServices{
  Future<String> getRouteCoordinates(LatLng l1, LatLng l2)async{
  //  var url = Uri.https('maps.googleapis.com', '/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=30.151291024911473, 71.42940741605356&key=$apiKey', {"q": "dart"});
    String url = "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=32.75854505072758, -117.07547847055227&key=$apiKey";
    http.Response response = await http.get(Uri.parse(url));
    Map values = jsonDecode(response.body);
    print("====================>>>>>>>>${values}");

    return values["routes"][0]["overview_polyline"]["points"];
  }
}

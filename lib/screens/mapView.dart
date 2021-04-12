import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class mapView extends StatefulWidget {
  @override
  _mapViewState createState() => _mapViewState();
}
class _mapViewState extends State<mapView> {
  GoogleMapController _controller;
  final CameraPosition _initialPosition = CameraPosition(target: LatLng(32.75914335350104, -117.0754778));
  final List<Marker> marker = [];
  addMarker(cordinate){
    int id = Random().nextInt(100);
  setState(() {
    marker.add(Marker(position: cordinate,markerId: MarkerId(id.toString())));
  });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _initialPosition,
        mapType: MapType.normal,
        onMapCreated: (controller){
          setState(() {
            _controller = controller;
          });
        },
        markers: marker.toSet(),
        onTap: (cordinate){
          _controller.animateCamera(CameraUpdate.newLatLng(cordinate));
          addMarker(cordinate);
        },
      ),
    );
  }
}

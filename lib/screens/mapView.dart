import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class mapView extends StatefulWidget {
  @override
  _mapViewState createState() => _mapViewState();
}

class _mapViewState extends State<mapView> {
  GoogleMapController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final CameraPosition _initialPosition =
  CameraPosition(target: LatLng(32.75914335350104, -117.0754778));
  final List<Marker> marker = [];
  Set<Marker> _markers = {};
  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId('id-1'),
          position: LatLng(32.75914335350104, -117.0754778),
          infoWindow: InfoWindow(
              title: 'Nilesisters',
              snippet: 'Nilesistes Development Initiative'
          )
      ),);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _initialPosition,
        markers: _markers,
        onMapCreated: _onMapCreated,
      ),
    );
  }
}

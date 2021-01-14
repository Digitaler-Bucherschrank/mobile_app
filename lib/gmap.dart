import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GMap extends StatefulWidget {
  GMap({Key key}) : super(key: key);
  @override
  _GMapState createState() => _GMapState();
}

class _GMapState extends State<GMap> {
  //Set<Marker> _markers = HashSet<Marker>();
  Set<Marker> _markers = {};
  //GoogleMapController _mapController;
  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId("0"),
          position: LatLng(50.109326, 8.671547),
          infoWindow: InfoWindow(
            title: "Englisches Theater",
            snippet: "-",
          ),
        ),
      );
    });

    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId("1"),
          position: LatLng(50.16702201577, 8.6181255255342),
          infoWindow: InfoWindow(
            title: "Frankfurt-Niederursel",
            snippet: "-",
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Map')),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(50.1109, 8.6821),
              zoom: 12,
            ),
            markers: _markers,
            myLocationEnabled: true,
          ),
        ],
      ),
    );
  }
}

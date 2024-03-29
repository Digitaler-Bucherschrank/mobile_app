import 'dart:async';
import 'package:digitaler_buecherschrank/utils/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../models/book_case.dart';
import 'bookcasemodel.dart';

String _darkMapStyle = "";
String _lightMapStyle = "";
Completer<GoogleMapController> _controller = new Completer();

// This is the implemented Google Maps Logic
class GMap extends StatefulWidget {
  GMap({Key? key}) : super(key: key);

  @override
  _GMapState createState() => _GMapState();
}

class _GMapState extends State<GMap> with WidgetsBindingObserver {
  Set<Marker> _markers = {};

  // Logic for dark/light theme for map
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    Future.wait([
      rootBundle.loadString('assets/map_styles/dark.json'),
      rootBundle.loadString('assets/map_styles/light.json')
    ]).then((value) {
      _darkMapStyle = value.first;
      _lightMapStyle = value.last;

      _setMapStyle();
    });
  }

  Future _setMapStyle() async {
    final controller = await _controller.future;
    final theme = WidgetsBinding.instance.window.platformBrightness;
    if (theme == Brightness.dark) {
      await controller.setMapStyle(_darkMapStyle);
    } else
      await controller.setMapStyle(_lightMapStyle);
  }

  @override
  void didChangePlatformBrightness() {
    setState(() {
      _setMapStyle();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 15,
    )));
  }

  void _onMapCreated(GoogleMapController controller) async {
    if (!_controller.isCompleted) {
      _controller.complete(controller);
    }

    var caseList = await getBookCases();

    for (var bookCase in caseList) {
      _markers.add(Marker(
          markerId: MarkerId('${bookCase.iId!.oid}'),
          position: LatLng(
            double.parse('${bookCase.lat}'),
            double.parse(
              '${bookCase.lon}',
            ),
          ),
          icon: await BitmapDescriptor.fromAssetImage(
              ImageConfiguration(devicePixelRatio: 5),
              'assets/icons/book_case.png'),
          onTap: () {
            showModalBottomSheet(
                backgroundColor: Theme.of(context).cardColor.withOpacity(0.6),
                context: context,
                builder: (builder) {
                  return BookCaseModel(bookCase);
                });
          }));
    }

    if (mounted) {
      setState(() => null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      compassEnabled: false,
      zoomControlsEnabled: false,
      initialCameraPosition: CameraPosition(
        target: LatLng(50.1109, 8.6821),
        zoom: 12,
      ),
      markers: Set<Marker>.of(_markers),
    );
  }
}

void currentLocation() async {
  final GoogleMapController controller = await _controller.future;
  LocationData userLocation = await LocationProvider.getLocation();
  controller.animateCamera(CameraUpdate.newCameraPosition(
    CameraPosition(
      bearing: 0,
      target: LatLng(userLocation.latitude!, userLocation.longitude!),
      zoom: 17.0,
    ),
  ));
}

Future<void> goToLocation(double lat, double long) async {
  final GoogleMapController controller = await _controller.future;
  return controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
    target: LatLng(lat, long),
    zoom: 15,
  )));
}

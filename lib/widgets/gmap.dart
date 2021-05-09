import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

// ignore: unused_import
import 'package:digitaler_buecherschrank/widgets/drawer.dart';
import 'package:digitaler_buecherschrank/utils/location.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:digitaler_buecherschrank/generated/l10n.dart';
import 'package:location/location.dart';
// ignore: unused_import
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import '../models/book_case.dart';
import 'book_info.dart';
import 'scanner/scanner_drop_form.dart';
import 'scanner/scanner_pickup_form.dart';

// ignore: unused_import
import 'drawer.dart';

String _darkMapStyle = "";
String _lightMapStyle = "";
Completer<GoogleMapController> _controller = new Completer();

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

    WidgetsBinding.instance!.addObserver(this);

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
    final theme = WidgetsBinding.instance!.window.platformBrightness;
    if (theme == Brightness.dark)
      controller.setMapStyle(_darkMapStyle);
    else
      controller.setMapStyle(_lightMapStyle);
  }

  @override
  void didChangePlatformBrightness() {
    setState(() {
      _setMapStyle();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
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
    _controller.complete(controller);

    var schraenke = await getBookCases();
    for (int i = 0; i < schraenke.length; i++) {
      var tempMarker = schraenke[i];
      _markers.add(Marker(
          markerId: MarkerId('${tempMarker.iId!.oid}'),
          position: LatLng(
            double.parse('${tempMarker.lat}'),
            double.parse(
              '${tempMarker.lon}',
            ),
          ),
          icon: await BitmapDescriptor.fromAssetImage(
              ImageConfiguration(devicePixelRatio: 5),
              'assets/icons/book_case.png'),
          onTap: () {
            showModalBottomSheet(
                context: context,
                builder: (builder) {
                  return Container(
                    height: 300,
                    color: Color(0xff757575),
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          ListTile(
                            title: Text('${tempMarker.title}'),
                          ),
                          ListTile(
                            title: Text('${tempMarker.address}'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              ElevatedButton(
                                  child: Text(S.of(context).label_dropbook),
                                  onPressed: () {
                                    print('${tempMarker.iId!.oid}');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ScannerDropForm(
                                              '${tempMarker.iId!.oid}')),
                                    );
                                  }),
                              ElevatedButton(
                                  child: Text(S.of(context).label_borrowbook),
                                  onPressed: () {
                                    print('${tempMarker.iId!.oid}');
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ScannerPickupForm(
                                                    '${tempMarker.iId!.oid}')));
                                  }),
                            ],
                          ),
                          ElevatedButton(
                              child: const Text("Siehe Bücher"),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          BookInfo('${tempMarker.iId!.oid}')),
                                );
                              }),
                          ElevatedButton(
                            child: const Text('Close BottomSheet'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                  );
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
  controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
    target: LatLng(lat, long),
    zoom: 15,
  )));
}

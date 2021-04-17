import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'models/book_case.dart';
import 'models/book_info.dart';
import 'scanner/scanner_drop_form.dart';
import 'scanner/scanner_pickup_form.dart';

class GMap extends StatefulWidget {
  GMap({Key key}) : super(key: key);
  @override
  _GMapState createState() => _GMapState();
}

class _GMapState extends State<GMap> {
  Set<Marker> _markers = {};
  void _onMapCreated(GoogleMapController controller) async {
    var schraenke = await schrankeFuture();
    print("blabla${schraenke.length}");
    for (int i = 0; i < schraenke.length; i++) {
      var tempMarker = schraenke[i];
      _markers.add(Marker(
          markerId: MarkerId('${tempMarker.iId.oid}'),
          position: LatLng(
            double.parse('${tempMarker.lat}'),
            double.parse(
              '${tempMarker.lon}',
            ),
          ),
          icon: await BitmapDescriptor.fromAssetImage(
              ImageConfiguration(devicePixelRatio: 5), 'assets/book.png'),
          onTap: () {
            showModalBottomSheet(
                context: context,
                builder: (builder) {
                  return Container(
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
                          ElevatedButton(
                              child: const Text("Siehe Bücher"),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BookInfo()),
                                );
                              }),
                          ElevatedButton(
                            child: const Text('Close BottomSheet'),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              ElevatedButton(
                                  child: const Text("Buch ablegen"),
                                  onPressed: () {
                                    print('${tempMarker.iId.oid}');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ScannerDropForm(
                                                  '${tempMarker.iId.oid}')),
                                    );
                                  }),
                              ElevatedButton(
                                  child: const Text("Buch aufheben"),
                                  onPressed: () {
                                    print('${tempMarker.iId.oid}');
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ScannerPickupForm(
                                                    '${tempMarker.iId.oid}')));
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }));
    }
    setState(() => null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            initialCameraPosition: CameraPosition(
              target: LatLng(50.1109, 8.6821),
              zoom: 12,
            ),
            markers: Set<Marker>.of(_markers),
          ),
        ],
      ),
    );
  }
}

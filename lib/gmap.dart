import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'search.dart';
import 'models/book_case.dart';
import 'models/book_info.dart';
import 'scanner/scanner_drop_form.dart';
import 'scanner/scanner_pickup_form.dart';

class GMap extends StatefulWidget {
  GMap({Key key}) : super(key: key);
  @override
  _GMapState createState() => _GMapState();
}

class Places {
  Id iId;
  String address;
  String bcz;
  String comment;
  String contact;
  String deactivated;
  String deactreason;
  String digital;
  String entrytype;
  String homepage;
  String icontype;
  String lat;
  String lon;
  String open;
  String title;
  String type;

  Places(
      {this.iId,
      this.address,
      this.bcz,
      this.comment,
      this.contact,
      this.deactivated,
      this.deactreason,
      this.digital,
      this.entrytype,
      this.homepage,
      this.icontype,
      this.lat,
      this.lon,
      this.open,
      this.title,
      this.type});

  Places.fromJson(Map<String, dynamic> json) {
    iId = json['_id'] != null ? new Id.fromJson(json['_id']) : null;
    address = json['address'];
    bcz = json['bcz'];
    comment = json['comment'];
    contact = json['contact'];
    deactivated = json['deactivated'];
    deactreason = json['deactreason'];
    digital = json['digital'];
    entrytype = json['entrytype'];
    homepage = json['homepage'];
    icontype = json['icontype'];
    lat = json['lat'];
    lon = json['lon'];
    open = json['open'];
    title = json['title'];
    type = json['type'];
  }
}

class Id {
  String oid;

  Id({this.oid});

  Id.fromJson(Map<String, dynamic> json) {
    oid = json[r"$oid"];
  }
}

class _GMapState extends State<GMap> with AutomaticKeepAliveClientMixin<GMap> {
  @override
  bool get wantKeepAlive => true;
//doesnt restart map

  Set<Marker> _markers = {};
  void _onMapCreated(GoogleMapController controller) async {
    var schraenke = await getBookCases();
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
                                      builder: (context) =>
                                          BookInfo('${tempMarker.iId.oid}')),
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
                                          builder: (context) => ScannerDropForm(
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
    super.build(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            scrollGesturesEnabled: true,
            tiltGesturesEnabled: true,
            initialCameraPosition: CameraPosition(
              target: LatLng(50.1109, 8.6821),
              zoom: 12,
            ),
            markers: Set<Marker>.of(_markers),
          ),
          Positioned(
            top: 10,
            right: 15,
            left: 15,
            child: Container(
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Container(
                    child: OutlinedButton(
                        child: Text("Suchen..."),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Search();
                          }));
                        }),
                    width: 300,
                    height: 80,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.deepPurple,
                      child: Text('JK'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'markers2.dart';
import 'dart:convert';
// ignore: unused_import
import 'package:flutter/services.dart' show rootBundle;
import 'BuchAnzeigen.dart';

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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.iId != null) {
      data['_id'] = this.iId.toJson();
    }
    data['address'] = this.address;
    data['bcz'] = this.bcz;
    data['comment'] = this.comment;
    data['contact'] = this.contact;
    data['deactivated'] = this.deactivated;
    data['deactreason'] = this.deactreason;
    data['digital'] = this.digital;
    data['entrytype'] = this.entrytype;
    data['homepage'] = this.homepage;
    data['icontype'] = this.icontype;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['open'] = this.open;
    data['title'] = this.title;
    data['type'] = this.type;
    return data;
  }
}

class Id {
  String oid;

  Id({this.oid});

  Id.fromJson(Map<String, dynamic> json) {
    oid = json[r"$oid"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[r'$oid'] = this.oid;
    return data;
  }
}

// TODO: Change Icon of Markers
class _GMapState extends State<GMap> {
  Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) async {
    debugPrint(jsonEncode(jsonDecode(await DefaultAssetBundle.of(context)
        .loadString("assets/markers.json"))[0]));
    var markers = jsonDecode(
        await DefaultAssetBundle.of(context).loadString("assets/markers.json"));
    for (final e in markers) {
      var tempMarker = Places.fromJson(e);
      _markers.add(Marker(
          markerId: MarkerId('${tempMarker.iId.oid}'),
          position: LatLng(
            double.parse('${tempMarker.lat}'),
            double.parse(
              '${tempMarker.lon}',
            ),
          ),
          onTap: () {
            //_settingModalBottomSheet(context);
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
                                                BuchAnzeigen()),
                                      );
                                    }),
                                ElevatedButton(
                                  child: const Text('Close BottomSheet'),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ])));
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
